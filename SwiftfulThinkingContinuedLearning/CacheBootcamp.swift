//
//  CacheBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 17/10/24.
//

import SwiftUI


class CacheManager {
    static let instace = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove( name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
   
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "steve-jobs"
    let manager = CacheManager.instace
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        withAnimation(.spring) {
            infoMessage = manager.remove(name: imageName)
        }
        
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from cache"
        } else {
            
            infoMessage = "Image not found in Cache"
        }
        withAnimation(.spring) {
            cachedImage = manager.get(name: imageName)
        }
    }
    
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
               
                Text("\(vm.infoMessage)")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue.cornerRadius(10))
                })
                    
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red.cornerRadius(10))
                })
            
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green.cornerRadius(10))
            })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
            
        }
    }
}

#Preview {
    CacheBootcamp()
}
