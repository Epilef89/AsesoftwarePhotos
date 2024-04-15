//
//  HomePresenterTest.swift
//  Created by David Felipe Cortes Gonzalez on 15/04/24.

@testable import PhotosAsesofware
import XCTest

final class HomePresenterTest: XCTestCase {
    
    // MARK: Subject under test
    private var interactor: StubHomeInteractor!
    private var router: StubHomeRouter!
    private var view: StubHomeView!
    private var sut: HomePresenter!
    
    // MARK: Init
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHomePresenter() {
        view = StubHomeView()
        router = StubHomeRouter()
        interactor = StubHomeInteractor()
        sut = HomePresenter(view: view, router: router, interactor: interactor)
    }
    
    // MARK: Tests
    
    func testViewdidload() {
        //Given
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertEqual(view.invocations, [.showLoader])
        XCTAssertEqual(interactor.invocations, [.getPhotos])
        
    }
    
    func testNumberOfPhotos() {
        //Given
        let photos = DummyData.photos
        sut.getPhotosSuccess(photos)
        
        //When
        let numberOfPhotos = sut.numberOfPhotos()
        
        //Then
        XCTAssert(photos.count == numberOfPhotos)
    }
    
    func testPhoto() {
        //Given
        let photos = DummyData.photos
        sut.getPhotosSuccess(photos)
        let index = 1
        //When
        let currentPhoto = sut.photo(at: index)
        //Then
        XCTAssertEqual(currentPhoto, photos[index])
    }
    
    func testShowPhotoDetail() {
        //Given
        let photos = DummyData.photos
        sut.getPhotosSuccess(photos)
        let index = 1
        //When
        sut.showPhotoDetail(at: index)
        //Then
        XCTAssertEqual(router.invocations, [.showDetail])
    }
    
    func testGetPhotosError() {
        //Given
        
        //When
        sut.getPhotosError()
        //Then
        XCTAssertEqual(view.invocations, [.hideLoader, .showError])
    }
    
    func testGetPhotosSuccess() {
        //Given
        let photos = DummyData.photos
        //When
        sut.getPhotosSuccess(photos)
        let numberOfPhotos = sut.numberOfPhotos()
        //Then
        XCTAssertEqual(photos.count, numberOfPhotos)
        XCTAssertEqual(view.invocations, [.hideLoader, .reloadPhotos])
    }
}

// MARK: StubHomeInteractor

private extension HomePresenterTest {
    
    class StubHomeInteractor: HomeInteractorProtocol {
        var presenter: HomeInteractorOutProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case getPhotos
        }
        
        // MARK: StubHomeInteractorProtocol implementations
        func getPhotos() {
            invocations.append(.getPhotos)
        }
    }
}

// MARK: StubHomeRouter

private extension HomePresenterTest {
    
    class StubHomeRouter: HomeRouterProtocol {
        var invocations: [Invocation] = []
        enum Invocation {
            case showDetail
        }
        
        // MARK: StubHomeRouterProtocol implementations
        func showDetail(photo: PhotosAsesofware.Photo) {
            invocations.append(.showDetail)
        }
    }
}

private extension HomePresenterTest {
    class StubHomeView: HomeViewProtocol {
        var presenter: HomePresenterProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case reloadPhotos
            case showLoader
            case hideLoader
            case showError
        }
        
        // MARK: StubHomeViewProtocol implementations
        func reloadPhotos() {
            invocations.append(.reloadPhotos)
        }
        
        func showLoader() {
            invocations.append(.showLoader)
        }
        
        func hideLoader() {
            invocations.append(.hideLoader)
        }
        
        func showError() {
            invocations.append(.showError)
        }
    }
}
