import Combine

protocol LoginUseCaseProtocol {
    func sendLogin(_ loginCredentials: LoginCredentials) -> AnyPublisher<UserResponse, ResponseError>
}

final class LoginUseCase: LoginUseCaseProtocol {
   
    private let authRepository: AuthRepositoryProtocol
    private let validator: LoginValidatorProtocol
    
    init(authRepository: AuthRepositoryProtocol,
         validator: LoginValidatorProtocol) {
        self.authRepository = authRepository
        self.validator = validator
    }
    
    deinit {
        print("LoginUseCase is deinit, No memory leak found")
    }

    func sendLogin(_ loginCredentials: LoginCredentials) -> AnyPublisher<UserResponse, ResponseError> {
        switch validateLoginData(loginCredentials) {
        case .success:
            return authRepository.login(loginCredentials)
        case .failure(let validationError):
            return Fail(error: .server(message: validationError.localizedDescription)).eraseToAnyPublisher()
        }
    }
    
    private func validateLoginData(_ loginCredentials: LoginCredentials) -> Result<Void, Error> {
        do {
           try validator.validate(phone: loginCredentials.phone)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
