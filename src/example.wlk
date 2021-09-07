import wollok.game.*

object pantalla {
	var capturas=0
	const alto=18
	const ancho=18
	const pokemones = [ pikachu, metapod, rat, fish]
	method iniciar() {
			
	  game.height(alto)
      game.width(ancho)
      game.title('Pokemons: Atrapalos ya!')
      game.boardGround("img/wallpaper.png")
      game.addVisual(ash)
      
//    game.addVisual(pikachu)
//	  game.addVisual(metapod)
//	  game.addVisual(rat)
//	  game.addVisual(fish)
	  
	  keyboard.left().onPressDo({ash.moverseIzquierda() })
      keyboard.right().onPressDo({ash.moverseDerecha() })
      keyboard.down().onPressDo({ash.moverseAbajo() })
      keyboard.up().onPressDo({ash.moverseArriba() })

//      game.whenCollideDo(pikachu,
//      	{algo => algo.teColisiono(pikachu)}
//      )
//	  game.whenCollideDo(metapod,
//	  	{algo => algo.teColisiono(metapod)}
//	  )
//	  game.whenCollideDo(rat,
//	  	 {algo => algo.teColisiono(rat)}
//	  )
//	  game.whenCollideDo(fish,
//	  	{algo => algo.teColisiono(fish)}
//	  )
	  
	  pokemones.forEach( 
	       {unPokemon => game.addVisual(unPokemon)
	       				 game.onTick(unPokemon.velocidad(), unPokemon.movimiento(),{self.haceCorrerA(unPokemon)})
	       	             game.whenCollideDo(unPokemon,{algo => algo.teColisiono(unPokemon)})
	       }) 

//	   game.onTick(pikachu.velocidad(), pikachu.movimiento(),{self.haceCorrerA(pikachu)})
//	   game.onTick(metapod.velocidad(), metapod.movimiento(),{self.haceCorrerA(metapod)})
//	   game.onTick(rat.velocidad(), rat.movimiento(),{self.haceCorrerA(rat)})
//	   game.onTick(fish.velocidad(), fish.movimiento(),{self.haceCorrerA(fish)})
    keyboard.a().onPressDo({ash.dispara(1) })
    keyboard.s().onPressDo({ash.dispara(2) })

  game.start()	
		
	}
	method sumarCaptura() { capturas += 1}
	
	method limites(posicion){
		var nuevaPos = posicion
		if(posicion.x() >= ancho) nuevaPos = game.at(ancho-1,nuevaPos.y())
		if(posicion.x() < 0) nuevaPos = game.at(0,nuevaPos.y())
		if(posicion.y() >= alto) nuevaPos = game.at(nuevaPos.x(),alto-1)
		if(posicion.y() < 0) nuevaPos = game.at(nuevaPos.x(),0)
		return nuevaPos
	} 
	
	method checkEndGame(){
		if(capturas==4){
		 game.say(ash,"Hemos ganado!")
		}
	}
	method haceCorrerA(pokemon) {
		const vertical = (-5..5).anyOne()
		const horizontal = (-5..5).anyOne()
		pokemon.position(self.limites(pokemon.position().right(horizontal).up(vertical)))
	}
}

object ash{
	
	var position = game.center()
	
	method position(){
		return position
	}
	method image(){
		return "img/ash.png"
	}
	
	method moverseDerecha(){
		position = position.right(1)
	}
	method moverseIzquierda(){
		position = position.left(1)
	}
	
	method moverseAbajo(){
		position = position.down(1)
	}
	
	method moverseArriba(){
		position = position.up(1)
	}
	
	method dispara(direccion) {
		pokebola.position(self.position())
		game.addVisual(pokebola)	
		pokebola.hacia(direccion)
		game.schedule(200, {pokebola.vuelve()})			
	}
		
	method teColisiono(alguien){}	
}

object pokebola{
	var property position = ash.position()
	
	method image(){
		return "img/pokebola.png"
	}
	
	method hacia(direccion){
              
        if(direccion==1)
		position=position.left(4)
		else
		position=position.right(4)
				
		} 
	
	method vuelve(){
		return game.removeVisual(self)		
	}
	
		method esPokebola(){
		return true
	}
	method teColisiono(pokemon){
      	self.esAtrapado(pokemon)
      	game.say(ash,pokemon.saludo())
      	pantalla.sumarCaptura()
      	pantalla.checkEndGame()
	}
	
	method esAtrapado(pokemon){
	  pokemon.position(pantalla.limites(position.up(3)))
	  game.removeTickEvent(pokemon.movimiento())
	  pokemon.image("img/atrapado.png")
	  game.schedule(3000, {game.removeVisual(pokemon)})
	}
}

object pikachu{
	var property position = game.at(2,3)
	var property image = "img/pikachu.png"
	
	method movimiento() = "corre pikachu"
	
     method saludo() = "pikachu te atrapé!"
     
     method teColisiono(alguien){}
	 	method velocidad() = 7000
}

object metapod{
	var property position = game.at(4,15)
	var property image = "img/metapod.png"
	
    method movimiento() = "corre metapod"	
 	method saludo() = "muy lento metapod"
 	method teColisiono(alguien){ }
 	method velocidad() = 1000
}

object rat{
	var property position = game.at(17,18)
	var property image = "img/rat.png"
	
	method movimiento() = "corre rat"
	
 	method teColisiono(alguien){ }
 	method saludo() = "si"
	method velocidad() = 7000

}

object fish{
	var property position = game.at(16,4)
	var property image = "img/fish.png"

	method movimiento() = "corre fish"
	
 	method teColisiono(alguien){ }
 	method velocidad() = 5000
 	
 	method saludo() = "tambien digo si"

}