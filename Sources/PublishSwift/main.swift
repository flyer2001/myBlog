import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct PublishSwift: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://s.popyvanov.ru")!
    var name = "Блог Попыванова Сергея"
    var description = "Ращу цифровой сад, а тут собираю плоды"
    var language: Language { .russian }
    var imagePath: Path? { nil }
    var favicon = Favicon(path: Path("images/favicon.png"), type: "image/x-icon")
}

// This will generate your website using the built-in Foundation theme:
try PublishSwift().publish(withTheme: .foundation)

