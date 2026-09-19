import UIKit // the whole swiftUI

let country = "Indonesia" // let is a constant. Once set, it is locked, set as constant if u don't know whether to change it in the future, restrictive
var score = 11 // var is a vaiable. It can be given a new value
let price = 19.99

score += 10
print("test integer:  \(score)")

print("\nHello from \(country)") // string interpolation

// only "" double quotation is allowed in swift

let name: String = "Rizky"
let years: Int = 21
let rating: Double = 4.5
let isAvailable: Bool = true

// type inference (no need to declare the variable type)
let town = "Malang"
let count = 7
let priceTest = 20.00

let myName = "Jerico Asan"
let myAge = 22
let myCity = "Jakarta"

print("\nHi I'm \(myName),\n I'm \(myAge) years old,\n and I'm from in \(myCity),\n nice to meet you!")

let isStudent: Bool = false
let yesOrNo = isStudent ? "yes" : "no"

print("\nAm I a student? \(yesOrNo)")

// Make Descision
// == is equal to
// != not equal to
// > greater, >=
// < less, <=
// && || and or

let yearsHoh = 4

if(yearsHoh >= 5)
{
    print("senior")
}
else if(yearsHoh >= 3)
{
    print("adult")
}
else
{
    print("child")
}

// array, struct, foreach
struct Mountain: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let height: Int
}

let mountains: [Mountain] = [
    Mountain(name: "Bromo", location: "East Java", height: 2329),
    Mountain(name: "Rinjani", location: "East Java", height: 2329),
    Mountain(name: "Sinabung", location: "East Java", height: 2329),
    Mountain(name: "Pangrango", location: "East Java", height: 2329)
]

// traverse
for mountain in mountains {
    print(mountain.name,mountain.location  ,mountain.height)
}




