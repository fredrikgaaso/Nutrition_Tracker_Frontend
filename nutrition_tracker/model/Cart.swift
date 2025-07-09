struct Cart: Codable, Identifiable {
    let id: Int
    let cartName: String
    let productsList: [Product]?
    let desiredProtein: Int
    let desiredCarbs: Int
    let desiredFat: Int
    let allergens: [String]?
}
