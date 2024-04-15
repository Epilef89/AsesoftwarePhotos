//
//  SplashPresenterTest.swift
//  Created by David Felipe Cortes Gonzalez on 15/04/24.


@testable import PhotosAsesofware
import XCTest

final class SplashPresenterTest: XCTestCase {
    
    // MARK: Subject under test
    private var interactor: StubSplashInteractor!
    private var router: StubSplashRouter!
    private var view: StubSplashView!
    private var sut: SplashPresenter!
    
    // MARK: Init
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupSplashPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSplashPresenter() {
        view = StubSplashView()
        router = StubSplashRouter()
        interactor = StubSplashInteractor()
        sut = SplashPresenter(view: view, router: router, interactor: interactor)
    }
    
    // MARK: Tests
    
    func testAnimationCompleted() {
        // Given
        
        // When
        sut.animationCompleted()
        
        // Then
        XCTAssertEqual(router.invocations, [.routerToHome])

    }
    

}

// MARK: StubSplashInteractor

private extension SplashPresenterTest {
    
    class StubSplashInteractor: SplashInteractorProtocol {
        var presenter: SplashInteractorOutProtocol?

    }
}

// MARK: StubSplashRouter

private extension SplashPresenterTest {
    
    class StubSplashRouter: SplashRouterProtocol {
        var invocations: [Invocation] = []
        enum Invocation {
            case routerToHome
        }
        
        // MARK: StubSplashRouterProtocol implementations
        func routerToHome() {
            invocations.append(.routerToHome)
        }
    }
}

private extension SplashPresenterTest {
    class StubSplashView: SplashViewProtocol {
        var presenter: SplashPresenterProtocol?

    }
}
