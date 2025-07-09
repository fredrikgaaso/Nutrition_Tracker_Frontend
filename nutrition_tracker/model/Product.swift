struct Product: Codable, Identifiable {
    let id: Int
    let productName: String
    let nutritionalInfo: [Nutrient]
    let calories: Double
    let quantity: Int?
    let foodGroup: String
    let parentGroup: String?
}
