import Vapor
import Fluent

struct RegisterRequest: Content {
    let email: String
    let fullname: String
    let password: String
    let userType: String
    let additionalDetails: [String: String]
}

struct LoginRequest: Content {
    let email: String
    let password: String
}

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "fullname")
    var fullname: String

    @Field(key: "passwordHash")
    var passwordHash: String

    @Field(key: "userType")
    var userType: String

    @Field(key: "additionalDetails")
    var additionalDetails: [String: String]

    init() {}
    
    init(email: String, fullname: String, passwordHash: String, userType: String, additionalDetails: [String: String]) {
        self.email = email
        self.fullname = fullname
        self.passwordHash = passwordHash
        self.userType = userType
        self.additionalDetails = additionalDetails
    }
}

struct AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes.grouped("auth")
        authRoutes.post("register", use: register)
        authRoutes.post("login", use: login)
    }

    func register(req: Request) async throws -> User.Public {
        let register = try req.content.decode(RegisterRequest.self)
        let passwordHash = try Bcrypt.hash(register.password)

        let user = User(
            email: register.email,
            fullname: register.fullname,
            passwordHash: passwordHash,
            userType: register.userType,
            additionalDetails: register.additionalDetails
        )
        try await user.save(on: req.db)
        return user.convertToPublic()
    }

    func login(req: Request) async throws -> User.Public {
        let login = try req.content.decode(LoginRequest.self)
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == login.email)
            .first()
        else {
            throw Abort(.unauthorized, reason: "Invalid email or password.")
        }
        guard try Bcrypt.verify(login.password, created: user.passwordHash) else {
            throw Abort(.unauthorized, reason: "Invalid email or password.")
        }
        return user.convertToPublic()
    }
}

extension User {
    struct Public: Content {
        var id: UUID?
        var email: String
        var fullname: String
        var userType: String
        var additionalDetails: [String: String]
    }
    
    func convertToPublic() -> Public {
        Public(id: id, email: email, fullname: fullname, userType: userType, additionalDetails: additionalDetails)
    }
}
