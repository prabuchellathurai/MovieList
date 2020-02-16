import Foundation

struct Movies {
    var movies: [Movie]
}

struct Movie {
    let name: String
    let genre: String
    let poster: String?
    let plot: String?
    let director: String?
    
    init() {
        name = "[Unknown]"
        genre = "[Unknown]"
        director = "[unknown]"
        poster = nil
        plot = nil
    }
}

extension Movies: Codable { }

extension Movie: Codable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        genre = try container.decode(String.self, forKey: .genre)
        director = try container.decode(String.self, forKey: .director)
        poster = try container.decodeIfPresent(String.self, forKey: .poster)
        plot = try container.decodeIfPresent(String.self, forKey: .plot)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Title"
        case genre = "Genre"
        case poster = "Poster "
        case plot = "Plot"
        case director = "Director"
    }
}
