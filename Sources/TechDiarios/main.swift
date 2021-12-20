import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct TechDiarios: Website {
  enum SectionID: String, WebsiteSectionID {
    // Add the sections that you want your website to contain here:
    case posts
  }
  
  struct ItemMetadata: WebsiteItemMetadata {
    // Add any site-specific metadata that you want to use here.
  }
  
  // Update these properties to configure your website:
  var url = URL(string: "https://tech-diarios.io")!
  var name = "Tech Diarios"
  var description = "Here I'll share my daily tech related works with you"
  var language: Language { .english }
  var imagePath: Path? { nil }
}

private extension Node where Context == HTML.BodyContext {
  static func myHeader<T: Website>(for context: PublishingContext<T>) -> Node {
    header(
      .wrapper(
        .nav(
          .class("site-name"),
          .a(
            .href("/"),
            .text(context.site.name)
          )
        )
      )
    )
  }
}

private extension Node where Context == HTML.BodyContext {
  
  static func wrapper(_ nodes: Node...) -> Node {
    .div(.class("wrapper"), .group(nodes))
  }
  
  static func header<T: Website>(
    for context: PublishingContext<T>,
    selectedSection: T.SectionID?
  ) -> Node {
    let sectionIDs = T.SectionID.allCases
    
    return .header(
      .wrapper(
        .a(.class("site-name"), .href("/"), .text(context.site.name)),
        .if(sectionIDs.count > 1,
            .nav(
              .ul(.forEach(sectionIDs) { section in
                .li(.a(
                  .class(section == selectedSection ? "selected" : ""),
                  .href(context.sections[section].path),
                  .text(context.sections[section].title)
                ))
              })
            )
        )
      )
    )
  }
  
  static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
    return .ul(
      .class("item-list"),
      .forEach(items) { item in
        .li(.article(
          .h1(.a(
            .href(item.path),
            .text(item.title)
          )),
          .tagList(for: item, on: site),
          .p(.text(item.description))
        ))
      }
    )
  }
  
  static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
    return .ul(.class("tag-list"), .forEach(item.tags) { tag in
      .li(.a(
        .href(site.path(for: tag)),
        .text(tag.string)
      ))
    })
  }
  
  static func footer<T: Website>(for site: T) -> Node {
    return .footer(
      .p(
        .text("Generated using "),
        .a(
          .text("Publish"),
          .href("https://github.com/johnsundell/publish")
        )
      )
    )
  }
}


struct MyHtmlFactory<Site: Website>: HTMLFactory {
  func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
    HTML(
        .lang(context.site.language),
        .head(for: index, on: context.site),
        .body(
            .header(for: context, selectedSection: nil),
            .wrapper(
                .h1(.text(index.title)),
                .p(
                    .class("description"),
                    .text(context.site.description)
                ),
                .h2("Latest content"),
                .itemList(
                    for: context.allItems(
                        sortedBy: \.date,
                        order: .descending
                    ),
                    on: context.site
                )
            ),
            .footer(for: context.site)
        )
    )
  }
  
  func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: section, on: context.site),
      .body(
        .header(for: context, selectedSection: section.id),
        .wrapper(
          .h1(.text(section.title)),
          .itemList(for: section.items, on: context.site)
        ),
        .footer(for: context.site)
      )
    )
  }
  
  func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .head(for: item, on: context.site),
      .body(
        .myHeader(for: context),
        .wrapper(
          .article(
            .div(
              .class("content"),
              .contentBody(item.body)
            ),
            .span("Tagged with: "),
            .tagList(for: item, on: context.site)
          )
        )
      )
    )
  }
  
  func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .body(
        .header(for: context, selectedSection: nil),
        .wrapper(.contentBody(page.body)),
        .footer(for: context.site)
      )
    )
  }
  
  func makeTagListHTML(for page: TagListPage,
                       context: PublishingContext<Site>) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .body(
        .wrapper(
          .h1("Browse all tags"),
          .ul(
            .class("all-tags"),
            .forEach(page.tags.sorted()) { tag in
              .li(
                .class("tag"),
                .a(
                  .href(context.site.path(for: tag)),
                  .text(tag.string)
                )
              )
            }
          )
        )
      )
    )
  }
  
  func makeTagDetailsHTML(for page: TagDetailsPage,
                          context: PublishingContext<Site>) throws -> HTML? {
    HTML(
      .lang(context.site.language),
      .head(for: page, on: context.site),
      .body(
        .wrapper(
          .h1(
            "Tagged with ",
            .span(.class("tag"), .text(page.tag.string))
          ),
          .a(
            .class("browse-all"),
            .text("Browse all tags"),
            .href(context.site.tagListPath)
          ),
          .itemList(
            for: context.items(
              taggedWith: page.tag,
              sortedBy: \.date,
              order: .descending
            ),
            on: context.site
          )
        )
      )
    )
  }
}

extension Theme {
  static var myTheme: Theme {
    Theme(
      htmlFactory: MyHtmlFactory(),
      resourcePaths: ["Resources/MyTheme/styles.css"]
    )
  }
}

// This will generate your website:
try TechDiarios().publish(withTheme: .myTheme)
