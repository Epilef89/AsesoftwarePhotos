//
//  DetailInteractorTest.swift
//  Created by David Felipe Cortes Gonzalez on 15/04/24.

@testable import PhotosAsesofware
import XCTest

final class DetailInteractorTest: XCTestCase {
    
    // MARK: Subject under test
    private var presenter: StubDetailInteractorOutProtocol!
    private var sut: DetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    // MARK: Tests
    func testDeletePhotoSuccess() {
        //Given
        sut = DetailInteractor(networkingPhotosAdapter: NetworkingPhotosAdapterMock())
        presenter = StubDetailInteractorOutProtocol()
        sut.presenter = presenter
        //When
        sut.deletePhoto(DummyData.photos[.zero])
        //Then
        XCTAssertEqual(presenter.invocations, [.deletedSuccess])
    }
    
    func testDeletePhotoFailure() {
        //Given
        sut = DetailInteractor(networkingPhotosAdapter: NetworkingPhotosAdapterMock(success: false))
        presenter = StubDetailInteractorOutProtocol()
        sut.presenter = presenter
        //When
        sut.deletePhoto(DummyData.photos[.zero])
        //Then
        XCTAssertEqual(presenter.invocations, [.deleteFailure])
    }
    
    func testDeletePhotoNoInternet() {
        //Given
        sut = DetailInteractor(networkingPhotosAdapter: NetworkingPhotosAdapterMock(hasInternet: false))
        presenter = StubDetailInteractorOutProtocol()
        sut.presenter = presenter
        //When
        sut.deletePhoto(DummyData.photos[.zero])
        //Then
        XCTAssertEqual(presenter.invocations, [.deletePending])
    }

}

private extension DetailInteractorTest {
    
    class StubDetailInteractorOutProtocol: DetailInteractorOutProtocol {
        var invocations: [Invocation] = []
        enum Invocation {
            case deletedSuccess
            case deleteFailure
            case deletePending
        }
        
        // MARK: Stub DetailInteractorOutProtocol implementations
        
        func deletedSuccess() {
            invocations.append(.deletedSuccess)
        }
        
        func deleteFailure() {
            invocations.append(.deleteFailure)
        }
        
        func deletePending() {
            invocations.append(.deletePending)
        }

    }
}

