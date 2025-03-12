import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    
    func loadFavorites() {
        // TODO: Implement loading favorites from storage
        // This is where you would load from UserDefaults, CoreData, or other storage
    }
    
    func addFavorite(_ favorite: Favorite) {
        favorites.append(favorite)
        saveFavorites()
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
        saveFavorites()
    }
    
    private func saveFavorites() {
        // TODO: Implement saving favorites to storage
        // This is where you would save to UserDefaults, CoreData, or other storage
    }
}

// Model for a favorite item
struct Favorite: Identifiable, Codable {
    let id: UUID
    let name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
} 