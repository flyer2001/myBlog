import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct PublishSwift: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
        case bio
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://s.popyvanov.ru/blog/")!
    var name = "Цифровой садик Попыванова Сергея"
    var description = "заметки, которые не помещаются в блокнот"
    var language: Language { .russian }
    var imagePath: Path? { nil }
    var favicon = Favicon(path: Path("images/favicon.png"), type: "image/x-icon")
}

try PublishSwift().publish(withTheme: .myBlogTheme)

