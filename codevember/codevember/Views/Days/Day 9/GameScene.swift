//
//  GameScene.swift
//  codevember
//
//  Created by Renan Germano on 13/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import SpriteKit

final class GameScene: SKScene {
    
    // MARK: - Properties
    
    private var height: CGFloat { self.size.height }
    private var width: CGFloat { self.size.width }
    
    private var colors: [UIColor]!
    private var columns: Int!
    private var columnWidth: CGFloat!
    private var lines: Int!
    private var lineHeight: CGFloat!
    private var elementSize: CGFloat!
    
    private var newCircle: SKShapeNode {
        let circle = SKShapeNode(circleOfRadius: self.elementSize * 0.5)
        let colorIndex = Int.random(in: 0..<self.colors.count)
        let color = self.colors[colorIndex]
        circle.name = "\(colorIndex)"
        circle.fillColor = color
        circle.strokeColor = color
        return circle
    }
    
    private var grid: [[Node]] = []
    
    private var selectedShape: SKShapeNode?
    private var animating: Bool = false
    
    var didFinishGameAction: ((_ total: Int, _ hitted: Int) -> Void)?
    
    // MARK: - Life cicle functions
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    // MARK: - Touches handler functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let position = touches.first?.location(in: self) else {
            return
        }
        
        let j = Int(position.x / self.columnWidth)
        let i = Int(position.y / self.lineHeight)
        
        if i < self.grid.count,
           j < self.grid[i].count,
           let shape = self.grid[i][j].shape,
           shape.contains(position) {
            self.selectedShape = shape
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard !self.animating, let position = touches.first?.location(in: self) else {
            return
        }
        
        let j = Int(position.x / self.columnWidth)
        let i = Int(position.y / self.lineHeight)
        
        if i < self.grid.count,
           j < self.grid[i].count,
           let shape = self.grid[i][j].shape,
           shape.contains(position),
           shape === self.selectedShape {
            self.processHitFor(node: self.grid[i][j])
        }
        self.selectedShape = nil
    }
    
    // MARK: - Aux functions
    
    private func printGrid() {
        print(" * * * GRID * * * ")
        for line in grid.reversed() {
            var string = ""
            for node in line {
                string += "\(node.shape != nil ? 1 : 0) "
            }
            print(string)
        }
        print(" * * * * * * * * * ")
    }
    
    private func printGridSelected() {
        print(" * * * GRID SELECTED * * * ")
        for line in grid.reversed() {
            var string = ""
            for node in line {
                string += node.selected ? "T " : "F "
            }
            print(string)
        }
        print(" * * * * * * * * * ")
    }
    
    func setUpProperties(columns: Int) {
        self.colors = [.red, .green, .blue, .yellow, .purple]
        self.columns = columns
        self.columnWidth = self.width/CGFloat(columns)
        self.lines = Int(self.height/columnWidth)
        self.lineHeight = self.height/CGFloat(lines)
        self.elementSize = (columnWidth > lineHeight ? lineHeight : columnWidth) * 0.9
    }
    
    func createGame() {
        for l in 1...(self.lines) {
            var line: [Node] = []
            for c in 1...self.columns {
                let circle = self.newCircle
                circle.position = CGPoint(x: (CGFloat(c) - 0.5) * columnWidth, y: (CGFloat(l) - 0.5) * lineHeight)
                line.append(Node(circle, l-1, c-1, false))
                self.scene?.addChild(circle)
            }
            self.grid.append(line)
        }
    }
    
    func tryAgain(columns: Int) {
        self.grid.removeAll()
        self.animating = false
        self.removeAllChildren()
        setUpProperties(columns: columns)
        createGame()
    }
    
    private func processHitFor(node: Node) {
        func getNeighborsWithTheSameColor(_ node: Node) -> [Node] {
            var neighborhood: [Node] = []
            
            // up
            if node.line < lines-1,
               !grid[node.line+1][node.column].selected,
               let upShape = grid[node.line+1][node.column].shape,
               node.shape?.name == upShape.name {
                grid[node.line+1][node.column].selected = true
                neighborhood.append(grid[node.line+1][node.column])
            }
               
            // down
            if node.line > 0,
               !grid[node.line-1][node.column].selected,
               let downShape = grid[node.line-1][node.column].shape,
               node.shape?.name == downShape.name {
                grid[node.line-1][node.column].selected = true
                neighborhood.append(grid[node.line-1][node.column])
            }
            
            // left
            if node.column > 0,
               !grid[node.line][node.column-1].selected,
               let leftShape = grid[node.line][node.column-1].shape,
               node.shape?.name == leftShape.name {
                grid[node.line][node.column-1].selected = true
                neighborhood.append(grid[node.line][node.column-1])
            }
            
            // right
            if node.column < columns-1,
               !grid[node.line][node.column+1].selected,
               let rightShape = grid[node.line][node.column+1].shape,
               node.shape?.name == rightShape.name {
                grid[node.line][node.column+1].selected = true
                neighborhood.append(grid[node.line][node.column+1])
            }
            
            return neighborhood
        }
        
        func hit(_ nodes: [Node]) {
            let disappear = SKAction.sequence([SKAction.fadeOut(withDuration: 0.5),
                                               SKAction.removeFromParent()])
            self.animating = true
            for node in nodes {
                node.shape?.run(disappear)
                node.shape = nil
            }
            self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                        SKAction.run(adjustGridVertically)]))
        }
        
        func adjustGridVertically() {
            var biggestAmountOfMoves: Int = 0
            var currentAmountOfMoves: Int = 0
            
            func tryToMoveDown(node: Node) {
                if node.line > 0 && grid[node.line-1][node.column].shape == nil {
                    currentAmountOfMoves += 1
                    
                    let aux = grid[node.line-1][node.column]
                    grid[node.line-1][node.column] = node
                    grid[node.line][node.column] = aux
                    
                    node.line -= 1
                    aux.line += 1
                    
                    tryToMoveDown(node: node)
                    node.shape?.run(SKAction.moveBy(x: 0, y: -lineHeight, duration: 0.2))
                } else {
                    if currentAmountOfMoves > biggestAmountOfMoves {
                        biggestAmountOfMoves = currentAmountOfMoves
                    }
                    currentAmountOfMoves = 0
                }
            }
            
            for c in 0..<columns {
                for l in 1..<lines {
                    let node = grid[l][c]
                    guard let _ = node.shape else { continue }
                    tryToMoveDown(node: node)
                }
            }
            
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: Double(biggestAmountOfMoves) * 0.2),
                SKAction.run(adjustGridHorizontally)
            ]))
        }
        
        func adjustGridHorizontally() {
            var biggestAmountOfMoves: Int = 0
            
            func move(column: Int, to newColumn: Int) {
                let moves = column - newColumn
                if moves > biggestAmountOfMoves {
                    biggestAmountOfMoves = moves
                }
                
                for l in 0..<lines {
                    let aux = grid[l][column]
                    let empty = grid[l][newColumn]
                    
                    grid[l][column] = empty
                    grid[l][newColumn] = aux
                    
                    aux.column = newColumn
                    empty.column = column
                    
                    aux.shape?.run(SKAction.moveBy(x: -(CGFloat(moves) * columnWidth), y: 0, duration: Double(moves) * 0.2))
                }
            }
            
            if let firstEmptyColumn = (grid[0].first { $0.shape == nil })?.column {
                var currentEmptyColumn = firstEmptyColumn
                for c in firstEmptyColumn+1..<columns {
                    if grid[0][c].shape != nil {
                        move(column: c, to: currentEmptyColumn)
                        currentEmptyColumn += 1
                    }
                }
            }
            
            self.run(SKAction.sequence([SKAction.wait(forDuration: Double(biggestAmountOfMoves) * 0.2),
                                        SKAction.run(checkIfGameEnded)]))
            
        }
        
        func checkIfGameEnded() {
            for line in grid {
                for node in line {
                    let nodes = getNeighborsWithTheSameColor(node)
                    if !nodes.isEmpty {
                        self.animating = false
                        nodes.forEach { $0.selected = false }
                        return
                    }
                }
            }
            didFinishGameAction?(lines * columns, (lines * columns) - self.children.count)
        }
        
        
        
        guard let _ = node.shape else {
            return
        }
        node.selected = true
        var nodes = [node]
        
        var i = 0
        while i < nodes.count {
            nodes.append(contentsOf: getNeighborsWithTheSameColor(nodes[i]))
            i += 1
        }
        
        if nodes.count > 1 {
            hit(nodes)
        } else {
            node.selected = false
        }
    }
    
}

fileprivate final class Node {
    
    var shape: SKShapeNode?
    var line: Int
    var column: Int
    var selected: Bool
    
    init(_ shape: SKShapeNode?, _ line: Int, _ column: Int, _ selected: Bool) {
        self.shape = shape
        self.line = line
        self.column = column
        self.selected = selected
    }
    
}
