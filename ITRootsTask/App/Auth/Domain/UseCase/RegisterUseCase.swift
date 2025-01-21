//
//  RegisterUseCase.swift
//  Mesllah
//
//  Created by Saad Sherif on 07/10/2024.
//

import Combine

protocol RegisterUseCaseProtocol {

    func exexuteRegister(_ registerData: RegisterModel) -> AnyPublisher<UserResponse, ResponseError>
}

final class RegisterUseCase: RegisterUseCaseProtocol {

    private var repository: AuthRepositoryProtocol
    private var validator: RegisterValidatorProtocol
    
    init(repository: AuthRepositoryProtocol,
         validator: RegisterValidatorProtocol) {
        self.repository = repository
        self.validator = validator
    }
    
    deinit {
        print("RegisterUseCase is deinit, No memory leak found")
    }
    
    func exexuteRegister(_ registerData: RegisterModel) -> AnyPublisher<UserResponse, ResponseError> {
        switch validateRegisterData(registerData) {
        case .success:
            return repository.sendRegister(registerData)
                .eraseToAnyPublisher()
        case .failure(let validationError):
            return Fail(error: .server(message: validationError.localizedDescription))
                .eraseToAnyPublisher()
        }
    }
}

extension RegisterUseCase {
    
    private func validateRegisterData(_ registerData: RegisterModel) -> Result<Void, Error> {
        do {
            try validator.validate(fullName: registerData.fullname)
            try validator.validate(userName:registerData.userName)
            try validator.validate(phone: registerData.phone)
            try validator.validate(email: registerData.email)
            try validator.validate(password: registerData.password)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
