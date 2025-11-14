//
//  main.swift
//  Projeto
//
//  Created by LUIZ FELIPE PEREIRA ARAUJO on 14/11/25.
//

import Foundation

//variaveis
enum erros: Error{
    case opcaoInvalida
    case nulo
}

var jogando = true
var menu = true

var jogador = (vida: 100, maxVida: 100)

let listaMagias = ["raio simples", "cura menor", "tiro acido", "cura melhorada", "bola de fogo", "alta cura", "super nova"]
let listaMagiasStats = [15, 15, 25, 30, 40, 40, 50]
let listaMagiasTipo = [
    "raio simples": "dano",
    "cura menor": "cura",
    "tiro acido": "dano",
    "cura melhorada": "cura",
    "bola de fogo": "dano",
    "alta cura": "cura",
    "super nova": "dano"
]

//print(listaMagiasTipo)

var magiasAprendidas = 1

let inimigos = ["SLIME", "LARGATO GIGANTE", "ORC", "DRAGÃO JOVEM", "GOLEM DE PEDRA", "DRAGÃO ADULTO"]

let inimigosVida = [40, 60, 85, 120, 150, 200]

let inimigosDano = [10, 15, 20, 25, 30, 35]

//print(inimigos)
//print(inimigosVida)
//print(inimigosDano)
//
//print(jogador)

func verificaMagia(x:Int) throws -> String{
    if x == 0{
        throw erros.nulo
    }
    if x - 1 < 0{
        throw erros.opcaoInvalida
    }
    if x - 1 > magiasAprendidas{
        throw erros.opcaoInvalida
    }
    else{
        return "voce usou \(listaMagias[x - 1])"
    }
}

func ataqueInimigo(iniatual: String, iniD: Int, jogV: Int) -> Int{
    let vida = jogV - iniD
    return vida
}

print("==== A JORNADA DO JOVEM FEITICEIRO ====")

print("""

        VOCÊ É UM JOVEM FEITICEIRO QUE PARTIU EM BUSCA DE
        BATALHAS PARA MELHORAR SUAS HABILIDADES MAGICAS

        VOCÊ DEVE ENFRENTAR INIMIGOS CADA VEZ MAIS FORTES
                  ATÉ COMPLETAR SEU OBJETIVO

""")
while jogando == true{
    
    
    
    for (x, _) in inimigos.enumerated(){
        let iniAtual = inimigos[x]
        var iniAtualHp = inimigosVida[x]
        let iniAtualDano = inimigosDano[x]
        //print(inimigos[x])
        print("=== \(inimigos[x]) APARECEU! ===")
        
        func tentaCurar(v: Int, vm: Int, c: Int) -> Int{
            var vida = v
            if v + c >= vm{
                vida = vm
            }else{
                vida = v + c
            }
            return vida
        }
        
        //combate
        while iniAtualHp >= 0 && jogador.vida >= 0{
            print("")
            print("Sua vida: \(jogador.vida)/\(jogador.maxVida)")
            print("vida do \(iniAtual): \(iniAtualHp)/\(inimigosVida[x])")
            
            print(
            """
                ESCOLHA SUA MAGIA
            
            """)
            
            for i in 0...magiasAprendidas{
                print("\(i + 1) - \(listaMagias[i])")
            }
            let escolha = readLine() ?? "0"
            let escolhaInt = Int(escolha) ?? 0
            
            do{
                let _ = try verificaMagia(x: escolhaInt)
                let tipoMagia = listaMagiasTipo[listaMagias[escolhaInt - 1]]
                //print(tipoMagia ?? "invalido")
                
                switch tipoMagia{
                    
                case "cura":
                    print("")
                    print("Você tenta se curar com: \(listaMagias[escolhaInt - 1])")
                    jogador.vida = tentaCurar(v: jogador.vida, vm: jogador.maxVida, c: listaMagiasStats[escolhaInt - 1])
                    print("Sua vida agora é: \(jogador.vida)")
                    print("\(iniAtual) ataca voce")
                    jogador.vida = ataqueInimigo(iniatual: iniAtual,iniD: iniAtualDano, jogV: jogador.vida)
                    print("")
                case "dano":
                    print("")
                    print("Você ataca \(iniAtual) com \(listaMagias[escolhaInt - 1])")
                    iniAtualHp = iniAtualHp - listaMagiasStats[escolhaInt - 1]
                    if iniAtualHp > 0{
                        print("\(iniAtual) ataca voce")
                        jogador.vida = ataqueInimigo(iniatual: iniAtual,iniD: iniAtualDano, jogV: jogador.vida)
                    }
                    print("")
                default:
                    print("")
                }
                
            }catch{
                print("Opção invalida, perca a rodada")
                print("\(iniAtual) ataca voce")
                jogador.vida = ataqueInimigo(iniatual: iniAtual,iniD: iniAtualDano, jogV: jogador.vida)
                if jogador.vida <= 0{
                    break
                }
            }
            
        }
        if jogador.vida <= 0{
            print("")
            print("Sua Jornada Falhou")
            break
        }
        print("")
        print("PARABÉNS VOCÊ DERROTOU \(iniAtual) E APRENDEU UMA NOVA MAGIA")
        magiasAprendidas = magiasAprendidas + 1
    }
    print("")
    print("VOCÊ DERROTOU OS INIMIGOS E VIROU UM GRANDE FEITICEIRO, PARABÉNS✨")
    print("""

                                ✨CREDITOS✨
            
                          LUIZ FELIPE PEREIRA ARAUJO
            
                              OBRIGADO POR JOGAR



            """)
    while menu == true{
        print("Deseja jogar de novo?")
        print("1 - SIM | 2 - NÃO")
        let jogarDNV = readLine()
        if jogarDNV == "2"{
            jogando = false
            break
        }
    }
    
}
