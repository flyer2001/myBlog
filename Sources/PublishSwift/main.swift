import Files
import Foundation
import Ink
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
    var favicon = Favicon(path: Path("Resources/favicon.png"), type: "image/x-icon")
}

//try PublishSwift().publish(withTheme: .myBlogTheme)
try PublishSwift().publish(using: [
    .generateHtmlFromMarkdownFiles(),
    .sortItems(by: \.date, order: .descending),
    .generateHTML(withTheme: .myBlogTheme),
    .generateSiteMap()
])

extension PublishingStep {
    static func generateHtmlFromMarkdownFiles() -> Self {
        step(named: "Создаю html файлы в кастомном шаге") { context in
            let folder = try context.folder(at: "Content")
            // TODO - место для кастомных модификаторов
            
            try await MarkdownFileHandler().addMarkdownFiles(in: folder, to: &context)
        }
    }
}
