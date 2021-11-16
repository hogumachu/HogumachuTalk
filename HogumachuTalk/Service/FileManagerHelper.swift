import Foundation

func documentDirectoryURL() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func documentDirectoryURL(fileName: String) -> URL {
    return documentDirectoryURL().appendingPathComponent(fileName)
}

func documentDirectoryURL(fileName: String, pathPrefix: String) -> URL {
    return documentDirectoryURL().appendingPathComponent(pathPrefix + "_" + fileName)
}

func documentDirectoryURLPath(fileName: String) -> String {
    return documentDirectoryURL().appendingPathComponent(fileName).path
}

func documentDirectoryURLPath(fileName: String, pathPrefix: String) -> String {
    return documentDirectoryURL().appendingPathComponent(pathPrefix + "_" + fileName).path
}

func existsFileInFileManager(fileName: String) -> Bool {
    return FileManager.default.fileExists(atPath: documentDirectoryURLPath(fileName: fileName))
}

func existsFileInFileManager(fileName: String, pathPrefix: String) -> Bool {
    return FileManager.default.fileExists(atPath: documentDirectoryURLPath(fileName: fileName, pathPrefix: pathPrefix))
}

func saveFileLocal(file: NSData, fileName: String, pathPrefix: String) {
    let documentURL = documentDirectoryURL().appendingPathComponent(pathPrefix + "_" + fileName, isDirectory: false)
    file.write(to: documentURL, atomically: true) // Atomically -> 덮어쓰기
}

func fileName(fileURL: String) -> String {
    // fileURL 에 User ID 앞에 _ 추가
    return ((fileURL.components(separatedBy: "_").last)?
                .components(separatedBy: "?").first)?
                .components(separatedBy: ".").first ?? ""
}

func jpgExtensionName(fileName: String) -> String {
    return fileName + ".jpg"
}
