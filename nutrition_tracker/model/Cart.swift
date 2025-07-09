struct cartModel: Codable, Identifiable {
    let id: Int
    let cartName: String
    let productList: [productModel]
    let desiredProtein: Int
    let desiredCarbs: Int
    let desiredFat: Int
    let allergens: [String]
}

struct productModel: Codable {
    let id: Int
    let productName: String
    let nutritionalInfo: [nutrientModel]
    let calories: Double
    let quantity: Int
    let foodGroup: String
    let parentGroup: String?
}

struct nutrientModel: Codable {
    let nutrientName: String
    let nutrientValue: Double
}
