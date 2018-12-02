//
//  FundFilter.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

enum RiskLevel: String {
    case conservador = "CONSERVADOR"
    case moderado = "MODERADO"
    case sofisticado = "SOFISTICADO"
}

enum FundCategory: String {
    case rendaFixa     = "Renda Fixa"
    case multimercados = "Multimercados"
    case acoes         = "Ações"
    case cambial       = "Cambial"
}

enum ApplicationInterval: Double {
    case upto0    =       0.0
    case upto100  =     100.0
    case upto500  =     500.0
    case upto1k   =   1_000.0
    case upto3k   =   3_000.0
    case upto5k   =   5_000.0
    case upto10k  =  10_000.0
    case upto15k  =  15_000.0
    case upto20k  =  20_000.0
    case upto25k  =  25_000.0
    case upto30k  =  30_000.0
    case upto50k  =  50_000.0
    case upto100k = 100_000.0
    case upto250k = 250_000.0
}

enum RescueInterval: String {
    case interval0 = "D+0"
    case interval1 = "D+1"
    case interval2 = "D+2"
    case interval3 = "D+4"
    case interval4 = "D+5"
    case interval5 = "D+6"
    case interval6 = "D+10"
    case interval7 = "D+11"
    case interval8 = "D+12"
    case interval9 = "D+13"
    case interval10 = "D+15"
    case interval11 = "D+16"
    case interval12 = "D+18"
    case interval13 = "D+21"
    case interval14 = "D+23"
    case interval15 = "D+24"
    case interval16 = "D+30"
    case interval17 = "D+31"
    case interval18 = "D+32"
    case interval19 = "D+33"
    case interval20 = "D+34"
    case interval21 = "D+35"
    case interval22 = "D+45"
    case interval23 = "D+46"
    case interval24 = "D+48"
    case interval25 = "D+60"
    case interval26 = "D+61"
    case interval27 = "D+63"
    case interval28 = "D+95"
    case interval29 = "D+181"
}

struct FundFilterOptions {
    var risk: RiskLevel?
    var category: FundCategory?
    var minimumApplication: ApplicationInterval?
    var rescueInterval: RescueInterval?
}
