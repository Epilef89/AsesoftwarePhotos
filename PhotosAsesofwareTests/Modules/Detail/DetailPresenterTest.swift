//
//  DetailPresenterTest.swift
//  Created by David Felipe Cortes Gonzalez on 15/04/24.

@testable import PhotosAsesofware
import XCTest

final class DetailPresenterTest: XCTestCase {
    
    // MARK: Subject under test
    private var interactor: StubDetailInteractor!
    private var router: StubDetailRouter!
    private var view: StubDetailView!
    private var sut: DetailPresenter!
    
    // MARK: Init
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailPresenter() {
        view = StubDetailView()
        router = StubDetailRouter()
        interactor = StubDetailInteractor()
        sut = DetailPresenter(view: view, router: router, interactor: interactor, photo: DummyData.photos[.zero])
    }
    
    // MARK: Tests
    
    func testViewDidLoad() {
        //Given
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertEqual(view.invocations, [.setupView])
    }
    
    func testDeleteImage() {
        //Given
        //When
        sut.deleteImage()
        //Then
        XCTAssertEqual(view.invocations, [.showLoader])
        XCTAssertEqual(interactor.invocations, [.deletePhoto])
    }
    
    func testRetry() {
        //Given
        //When
        sut.retry()
        //Then
        XCTAssertEqual(view.invocations, [.showLoader])
        XCTAssertEqual(interactor.invocations, [.deletePhoto])
    }
    
    func testBackToHome() {
        //Given
        //When
        sut.backToHome()
        //Then
        XCTAssertEqual(router.invocations, [.backView])
    }
    
    func testDeletedSuccess() {
        //Given
        //When
        sut.deletedSuccess()
        //Then
        XCTAssertEqual(view.invocations, [.hideLoader, .showConfirmation])
    }
    
    func testDeleteFailure() {
        //Given
        //When
        sut.deleteFailure()
        //Then
        XCTAssertEqual(view.invocations, [.hideLoader, .showErrorMessage])
    }
    
    func testDeletePending() {
        //Given
        //When
        sut.deletePending()
        //Then
        XCTAssertEqual(view.invocations, [.hideLoader, .showPendingDeletionMessage])
    }

}

// MARK: StubDetailInteractor

private extension DetailPresenterTest {
    
    class StubDetailInteractor: DetailInteractorProtocol {
        var presenter: DetailInteractorOutProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case deletePhoto
        }
        
        // MARK: StubDetailInteractorProtocol implementations
        func deletePhoto(_ photo: PhotosAsesofware.Photo) {
            invocations.append(.deletePhoto)
        }
    }
}

// MARK: StubDetailRouter

private extension DetailPresenterTest {
    
    class StubDetailRouter: DetailRouterProtocol {
        var invocations: [Invocation] = []
        enum Invocation {
            case backView
        }
        
        // MARK: StubDetailRouterProtocol implementations
        func backView() {
            invocations.append(.backView)
        }
    }
}

private extension DetailPresenterTest {
    class StubDetailView: DetailViewProtocol {
        var presenter: DetailPresenterProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case setupView
            case showErrorMessage
            case showPendingDeletionMessage
            case showConfirmation
            case showLoader
            case hideLoader
        }
        
        // MARK: StubDetailViewProtocol implementations
        func setupView(photo: PhotosAsesofware.Photo) {
            invocations.append(.setupView)
        }
        
        func showErrorMessage() {
            invocations.append(.showErrorMessage)
        }
        
        func showPendingDeletionMessage() {
            invocations.append(.showPendingDeletionMessage)
        }
        
        func showConfirmation() {
            invocations.append(.showConfirmation)
        }
        
        func showLoader() {
            invocations.append(.showLoader)
        }
        
        func hideLoader() {
            invocations.append(.hideLoader)
        }
    }
}
