//
//  AspectVGrid.swift
//  MemoryGameDemo
//
//  Created by Yuki Muto on 2/5/23.
//         -- Originally written by CS193p Instructor (Stanford Univerity)

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    // content function passed here will "escape" (been stored) from init for later use
    // @escaping keyword to let the compiler to know
    // @ViewBuilder keyword to accept any passing function to be recognized as a View Builder
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            // Make VStack flexible by adding Spacer, therefore GeometryReaer flexible too
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                // make sure the space between rows are zero for function widthThatFits to work
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
        
    }
    
    // make sure the space between columns are zero for function widthThatFits to work
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    // The function assumes no spacing between items
    // -- Add padding to each item so that the function incorporates them before calculation
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
