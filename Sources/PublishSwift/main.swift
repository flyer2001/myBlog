import Files
import Foundation
import Ink
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct PublishSwift: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://s.popyvanov.ru/")!
    var name = "Цифровой садик Попыванова Сергея"
    var description = "заметки, которые не помещаются в блокнот"
    var language: Language { .russian }
    var imagePath: Path? { nil }
    var favicon = Favicon(path: Path("Resources/favicon.png"), type: "image/x-icon")
}

try PublishSwift().publish(using: [
    .installPlugin(.splash(withClassPrefix: "splash")),
    .generateHtmlFromMarkdownFiles(),
    .sortItems(by: \.date, order: .descending),
    .generateHTML(withTheme: .myBlogTheme),
    .generateSiteMap()
])

extension PublishingStep {
    static func generateHtmlFromMarkdownFiles() -> Self {
        step(named: "Создаю html файлы в кастомном шаге") { context in
            let folder = try context.folder(at: "Content")
            
            let subFolderResult = try context.folder(at: "Content/posts")
            
            var paths: [String: String] = [:]
            try subFolderResult.files.forEach { file in
                let markdown = try context.markdownParser.parse(file.readAsString())
                let path = markdown.metadata["path"]
                let name = String(file.name.dropLast(3)) // remove .md extension
                paths[name] = path //
            }
            context.markdownParser.addModifier(.wikiLinker(paths: paths, postsPathUrl: context.site.url.absoluteString + "posts/"))
            
            try await MarkdownFileHandler().addMarkdownFiles(in: folder, to: &context)
        }
    }
}

public extension Modifier {
    static func wikiLinker(paths: [String:String], postsPathUrl: String) -> Self {
        Modifier(target: .paragraphs) { html, markdown in
            var result = html
            let regex = try! NSRegularExpression(pattern: "\\[\\[(.*?)\\]\\]", options: [])
            
            let matches = regex.matches(
                in: html,
                options: [],
                range: NSRange(location: 0, length: html.utf16.count)
            )
            
            for match in matches.reversed() {
                let rangeOfLinkWithoutBrackets = match.range(at: 1)
                var outputLink = "" 
                if let range = Range(rangeOfLinkWithoutBrackets, in: html) {
                    let wikiLinkString = String(html[range])
                    // discover - статья заглушка
                    let urlPath = postsPathUrl + (paths[wikiLinkString] ?? "discover")
                    
                    outputLink = "<a href=\"\(urlPath)\">\(wikiLinkString)</a>"
                    
                    let range = Range(match.range, in: result)!
                    
                    result = result.replacingCharacters(in: range, with: outputLink)
                }
            }

            return result
        }
    }
}
