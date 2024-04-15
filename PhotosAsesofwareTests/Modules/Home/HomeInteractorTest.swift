//
//  HomeInteractorTest.swift
//  Created by David Felipe Cortes Gonzalez on 15/04/24.


@testable import PhotosAsesofware
import XCTest

final class HomeInteractorTest: XCTestCase {
    
    // MARK: Subject under test
    private var presenter: StubHomeInteractorOutProtocol!
    private var sut: HomeInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testGetPhotosSuccess(){
        // Given
        sut = HomeInteractor(networkingHomeAdapter: NetworkingPhotosAdapterMock(success: true))
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
        // When
        sut.getPhotos()
        
        // Then
        XCTAssertEqual(presenter.invocations, [.getPhotosSuccess])
    }
    
    func testGetPhottosError(){
        // Given
        sut = HomeInteractor(networkingHomeAdapter: NetworkingPhotosAdapterMock(success: false))
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
        // When
        sut.getPhotos()
        
        // Then
        XCTAssertEqual(presenter.invocations, [.getPhottosError])
    }
}

private extension HomeInteractorTest {
    
    class StubHomeInteractorOutProtocol: HomeInteractorOutProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation {
            case getPhottosError
            case getPhotosSuccess
        }
        
        // MARK: Stub HomeInteractorOutProtocol implementations
         
         func getPhotosError() {
             invocations.append(.getPhottosError)
         }
         
         func getPhotosSuccess(_ photos: [PhotosAsesofware.Photo]) {
             invocations.append(.getPhotosSuccess)
         }
    }
}

