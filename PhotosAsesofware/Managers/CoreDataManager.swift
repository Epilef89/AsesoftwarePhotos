//
//  CoreDataManager.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 11/04/24.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotosAsesofware")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error al cargar el contenedor persistente: \(error)")
            }
        }
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func save(photo: Photo) {
        let fetchRequest: NSFetchRequest<MyPhotos> = MyPhotos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", photo.id)
        
        do {
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.persistentStoreCoordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator
            
            let existingPhotos = try privateContext.fetch(fetchRequest)
            
            for existingPhoto in existingPhotos {
                existingPhoto.albumId = Int64(photo.albumId)
                existingPhoto.title = photo.title
                existingPhoto.url = photo.url
                existingPhoto.thumbnailUrl = photo.thumbnailUrl
                if existingPhoto.image == nil {
                    downloadImage(for: existingPhoto, using: privateContext)
                } else {
                    try privateContext.save()
                }
            }
            if existingPhotos.isEmpty {
                let newPhoto = MyPhotos(context: privateContext)
                newPhoto.albumId = Int64(photo.albumId)
                newPhoto.id = Int64(photo.id)
                newPhoto.title = photo.title
                newPhoto.url = photo.url
                newPhoto.thumbnailUrl = photo.thumbnailUrl
                downloadImage(for: newPhoto, using: privateContext)
            }
        } catch {
            print("Error al recuperar/guardar fotos: \(error)")
        }
    }
    
    func deletePhoto(withId id: Int64) {
        let fetchRequest: NSFetchRequest<MyPhotos> = MyPhotos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.persistentStoreCoordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator
            
            let existingPhotos = try privateContext.fetch(fetchRequest)
            
            for existingPhoto in existingPhotos {
                privateContext.delete(existingPhoto)
            }
            
            try privateContext.save()
        } catch {
            print("Error al eliminar la foto: \(error)")
        }
    }
    
    func getFotos() -> [Photo]? {
        let fetchRequest: NSFetchRequest<MyPhotos> = MyPhotos.fetchRequest()
        
        do {
            let fotos = try managedObjectContext.fetch(fetchRequest)
            return fotos.map({ Photo(albumId: $0.albumId, id: $0.id, title: $0.title ?? "", url: $0.url ?? "", thumbnailUrl: $0.thumbnailUrl ?? "", image: $0.image) })
        } catch {
            fatalError("Error al obtener fotos de Core Data: \(error)")
        }
    }
    
    func getPhoto(id: Int64) -> Data? {
        let fetchRequest: NSFetchRequest<MyPhotos> = MyPhotos.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let photos = try managedObjectContext.fetch(fetchRequest)
            if let photo = photos.first {
                return photo.image
            } else {
                return nil
            }
        } catch {
            fatalError("Error al obtener la foto de Core Data: \(error)")
        }
    }

    private func downloadImage(for photo: MyPhotos, using context: NSManagedObjectContext) {
        guard let urlString = photo.url,  let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                do {
                    try context.save()
                } catch {
                    print("Error al guardar la imagen descargada: \(error)")
                }
                return
            }
            photo.image = data
            do {
                try context.save()
            } catch {
                print("Error al guardar la imagen descargada: \(error)")
            }
        }
        task.resume()
    }

}
