import Foundation

struct Movies {
    var movies: [Movie]
}

struct Movie {
    let name: String
    let genre: String
    let poster: String?
    
    init() {
        name = "[Unknown]"
        genre = "[Unknown]"
        poster = nil
    }
}

extension Movies: Codable { }

extension Movie: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        genre = try container.decode(String.self, forKey: .genre)
        poster = try container.decodeIfPresent(String.self, forKey: .poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Title"
        case genre = "Genre"
        case poster = "Poster "
        
    }
}
