//
//  NavigationHeader.swift
//  MessagingApp
//
//  Created by Vlad Gradskiy on 18.02.2024.
//  

import SwiftUI

private enum Constants {
    static let height: CGFloat = 44.0
    static let font = Font.system(size: 17.0, weight: .semibold)
    static let leadingPadding: CGFloat = 8.0
    static let trailingPadding: CGFloat = 16.0
    static let leadingContentSpacing: CGFloat = 3.0
    
    enum BackButton {
        static let iconSytem = "chevron.left"
        static let width: CGFloat = 33.0
        static let font: Font = .system(size: 19, weight: .semibold)
        
    }
}

public struct NavigationHeader<Trailing, Leading>: View where Trailing: View, Leading: View{
    
    let title: String
    let backButtonAction: (() -> Void)?
    let foregroundColor: Color
    var trailingContent: (() -> Trailing)?
    var leadingContent: (() -> Leading)?
    
    public init(
        title: String,
        foregroundColor: Color = .black,
        backButtonAction: (() -> Void)? = nil
    ) where Trailing == EmptyView, Leading == EmptyView  {
        self.title = title
        self.backButtonAction = backButtonAction
        self.foregroundColor = foregroundColor
        self.trailingContent = nil
    }
    
    public init(
        title: String,
        foregroundColor: Color = .black,
        backButtonAction: (() -> Void)? = nil,
        @ViewBuilder trailingContent: @escaping () -> Trailing
    ) where Leading == EmptyView{
        self.title = title
        self.backButtonAction = backButtonAction
        self.foregroundColor = foregroundColor
        self.trailingContent = trailingContent
    }
    
    public init(
        title: String,
        foregroundColor: Color = .black,
        backButtonAction: (() -> Void)? = nil,
        @ViewBuilder leadingContent: @escaping () -> Leading
    ) where Trailing == EmptyView{
        self.title = title
        self.backButtonAction = backButtonAction
        self.foregroundColor = foregroundColor
        self.leadingContent = leadingContent
        self.trailingContent = nil
    }
    
    public init(
        title: String,
        foregroundColor: Color = .black,
        backButtonAction: (() -> Void)? = nil,
        @ViewBuilder trailingContent: @escaping () -> Trailing,
        @ViewBuilder leadingContent: @escaping () -> Leading
    ) {
        self.title = title
        self.backButtonAction = backButtonAction
        self.foregroundColor = foregroundColor
        self.trailingContent = trailingContent
        self.leadingContent = leadingContent
    }
    
    //MARK: - Lyfe Cycle
    public var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            leadingContentStack
            Spacer()
            trailingContent?()
        }
        .padding(.leading, Constants.leadingPadding)
        .padding(.trailing, Constants.trailingPadding)
        .overlay(alignment: .center) {
            Text(title)
                .font(Constants.font)
                .foregroundColor(foregroundColor)
                .padding(.vertical, 11)
        }
        .frame(height: Constants.height)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    @ViewBuilder
    var leadingContentStack: some View {
        HStack(spacing: Constants.leadingContentSpacing) {
            if let backButtonAction {
                Button(action: backButtonAction) {
                    Image(systemName: Constants.BackButton.iconSytem)
                        .font(Constants.BackButton.font)
                        .foregroundColor(foregroundColor)
                }
            } else {
                Rectangle().fill(.clear).frame(width: 5)
            }
            leadingContent?()
        }
    }
}
