require(XML)
#require(ctv)

view <- newXMLDoc()
viewNode <- newXMLNode("CRANTaskView", doc=view)
newXMLNode("name", parent=viewNode, .children="MyView")
newXMLNode("topic", parent=viewNode, .children="僕の考えた最強のビュー")
newXMLNode("maintainer", parent=viewNode, attrs=c(email="mail@example.com"), .children="Example Taro")
newXMLNode("version", parent=viewNode, .children=strftime(Sys.Date(), "%Y-%m-%d"))
newXMLNode("info", parent=viewNode, .children="Just listed installed pakcages.")
packagelistNode <- newXMLNode("packagelist", parent=viewNode)
for (packageName in installed.packages()[, "Package"]) {
   priority <- ifelse(paste("package", packageName, sep = ":") %in% search(), "core", "normal")
   newXMLNode("pkg", parent=packagelistNode, attrs=c(priority=priority), .children=packageName)
}
linksNode <- newXMLNode("links", parent=viewNode)
newXMLNode("a", parent=linksNode, attrs=c(href="http://cran.r-project.org/web/packages/ctv/vignettes/ctv-howto.pdf"), .children="Writing CRAN Task Views")
newXMLNode("a", parent=linksNode, attrs=c(href="http://cran.r-project.org/web/views/"), .children="CRAN Task Views")
newXMLNode("a", parent=linksNode, attrs=c(href="http://www.okada.jp.org/RWiki/?CRAN%20Task%20View"), .children="CRAN Task View - RjpWiki")

saveXML(view, "myview.ctv")

# myview <- read.ctv("myview.ctv")
# myview$repository <- "http://cran.r-project.org/"
# install.views(myview)
