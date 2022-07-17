//
//  RickMortyViewModel.swift
//  Rick And Morty
//
//  Created by Burak AKCAN on 17.07.2022.
//

import Foundation

protocol IRickMortyViewModel{
    func fetcItems()
    func changeLoading()
    var rickMortyCharacters: [Result] { get set }
    var rickMortyService:IRickMortyService {get set }
    var rickMortyOutput:RickMortyOutput?{get}
    func setDelegate(output:RickMortyOutput)
}

final class RickMortyViewModel:IRickMortyViewModel{
    var rickMortyOutput: RickMortyOutput?
    
    func setDelegate(output: RickMortyOutput) {
        rickMortyOutput = output
    }
    
   private var isLoading = false
    var rickMortyCharacters: [Result] = []
    
    var rickMortyService: IRickMortyService
    
    init(){
        rickMortyService = RickMortyService()
    }
    
    func fetcItems() {
        changeLoading()
        rickMortyService.fetcAllData { [weak self] response in
            self?.changeLoading()
            self?.rickMortyCharacters = response ?? []
            self?.rickMortyOutput?.saveDatas(values: self?.rickMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
