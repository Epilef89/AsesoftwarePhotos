//
//  DetailStrings.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 11/04/24.
//

import Foundation

extension Strings {
    struct Detail {
        static let title: String = { "Detail.title".localizable }()
        static let albumTitle: String = { "Detail.title".localizable }()
        static let deleteAction: String = { "Detail.deleteAction".localizable }()
        struct PopUpMessage {
            struct Success {
                static let message: String = { "Detail.popUpMessage.Success.message".localizable }()
                static let action: String = { "Detail.popUpMessage.Success.action".localizable }()
            }
            struct Failure {
                static let message: String = { "Detail.popUpMessage.Failure.message".localizable }()
                static let retry: String = { "Detail.popUpMessage.Failure.retry".localizable }()
                static let later: String = { "Detail.popUpMessage.Failure.later".localizable }()
            }
            struct ConnetionFail {
                static let message: String = { "Detail.popUpMessage.ConnetionFail.message".localizable }()
                static let later: String = { "Detail.popUpMessage.ConnetionFail.later".localizable }()
            }
        }
    }
}
