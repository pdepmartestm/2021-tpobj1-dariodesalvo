import wollok.game.*

object pantalla {
	var capturas=0
	const alto=18
	const ancho=18
	method iniciar() {
			
	  game.height(alto)
      game.width(ancho)
      game.title('Pokemons: Atrapalos ya!')
      game.boardGround("img/wallpaper.png")
      game.addVisual(ash)
      game.addVisual(pikachu)
	  game.addVisual(metapod)
	  game.addVisual(rat)
	  game.addVisual(fish)
	  
	  keyboard.left().onPressDo({ash.moverseIzquierda() })
      keyboard.right().onPressDo({ash.moverseDerecha() })
      keyboard.down().onPressDo({ash.moverseAbajo() })
      keyboard.up().onPressDo({ash.moverseArriba() })
      
     keyboard.a().onPressDo({ash.dispara(1) })
     keyboard.s().onPressDo({ash.dispara(2) })
      
      game.whenCollideDo(pikachu,{algo => 
      	if (algo.esPokebola()){
      	pikachu.esAtrapado()
      	game.say(ash,"pikachu te atrapé!")
      	capturas += 1
      	self.checkEndGame()}
      })
	  game.whenCollideDo(metapod,{algo =>
	  	if (algo.esPokebola()){
	  	metapod.esAtrapado()
	  	game.say(ash,"muy lento metapod")
	    capturas += 1
      	self.checkEndGame()}
	  })
	  game.whenCollideDo(rat,{algo =>
	  	if (algo.esPokebola()){
	  	rat.esAtrapado()
	  	game.say(ash,"sí!")
	  	capturas += 1
      	self.checkEndGame()}
	  })
	  game.whenCollideDo(fish,{algo =>
	  	if (algo.esPokebola()){
	  	fish.esAtrapado()
	    game.say(ash,"sí!")
	    capturas += 1
      	self.checkEndGame()}
	  })
	  
	   game.onTick(5000, "corre pikachu",{pikachu.corre()})
	   game.onTick(7000, "corre metapod",{metapod.corre()})
	   game.onTick(1000, "corre rat",{rat.corre()})
	   game.onTick(5000, "corre fish",{fish.corre()})
	  game.start()	
		
	}
	
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
		pokebola.setPosition(self.position())
		game.addVisual(pokebola)	
		pokebola.hacia(direccion)
		game.schedule(200, {pokebola.vuelve()})			
	}
		
	method esAtrapado(){		
	}
	
	method esPokebola(){
		return false
	}
}

object pokebola{
	var position = ash.position()
	
	method position(){
		return position
	}
	
	method setPosition(posicion){
		position=posicion
	}
	
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
}

object pikachu{
	var position = game.at(2,3)
	var image = "img/pikachu.png"
	
		method position(){
		return position
	}
	method image(){
		return image
	}
	
	
	method esAtrapado(){
	  position=pantalla.limites(position.up(3))
	  game.removeTickEvent("corre pikachu")
	  image = "img/atrapado.png"
	  game.schedule(3000, {game.removeVisual(self)})
	  
	}
	
	method corre(){
	
	const vertical = (-5..5).anyOne()
	const horizontal = (-5..5).anyOne()
	position=pantalla.limites(position.right(horizontal).up(vertical))
	}
	
	method esPokebola(){
		return false
	}
	 
}

object metapod{
	var position = game.at(4,15)
	var image = "img/metapod.png"
	
		method position(){
		return position
	}
	method image(){
		return image
	}
	
	method esAtrapado(){
	  position=pantalla.limites(position.up(3))
	  game.removeTickEvent("corre metapod")
	  image = "img/atrapado.png"
	  game.schedule(3000, {game.removeVisual(self)})	
	} 
	
	method corre(){
	
	const vertical = (-5..5).anyOne()
	const horizontal = (-5..5).anyOne()
	position=pantalla.limites(position.right(horizontal).up(vertical))
	}
	
	method esPokebola(){
		return false
	}
}

object rat{
	var position = game.at(17,18)
	var image = "img/rat.png"
	
		method position(){
		return position
	}
	method image(){
		return image
	}
	
	method esAtrapado(){
	  position=pantalla.limites(position.up(3))
	  game.removeTickEvent("corre rat")
	  image = "img/atrapado.png"
	  game.schedule(3000, {game.removeVisual(self)})	
	}
	
	method corre(){
	
	const vertical = (-5..5).anyOne()
	const horizontal = (-5..5).anyOne()
	position=pantalla.limites(position.right(horizontal).up(vertical))
	} 
	
	method esPokebola(){
		return false
	}
}

object fish{
	var position = game.at(16,4)
	var image = "img/fish.png"
		method position(){
		return position
	}
	method image(){
		return image
	}
	
	method esAtrapado(){
	  position=pantalla.limites(position.up(3))
	  game.removeTickEvent("corre fish")
	  image = "img/atrapado.png"
	  game.schedule(3000, {game.removeVisual(self)})	
	}
	
	method corre(){
	
	const vertical = (-5..5).anyOne()
	const horizontal = (-5..5).anyOne()
	position=pantalla.limites(position.right(horizontal).up(vertical))
	}
	
	method esPokebola(){
		return false
	}
}