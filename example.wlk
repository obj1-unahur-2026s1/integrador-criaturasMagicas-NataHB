class Criatura {
  const poderMagico
  const astucia
  var rol

  method poderOfensivo() = poderMagico*10 + rol.poderExtra()
  method esAstuta()
  method esExtraordinaria() = rol.esExtraordinario(self)
  method esFormidable() = self.esAstuta() or self.esExtraordinaria()
  method cambiarRol() { rol = rol.nuevoRol() }
}

class Hada inherits Criatura{
  var kmQuePuedeVolar = 2
  method kmQuePuedeVolar() = kmQuePuedeVolar
  method aumentarKm(cantKm) { kmQuePuedeVolar = (kmQuePuedeVolar + cantKm).min(25) }  
  override method esAstuta() = astucia > 50
  override method esExtraordinaria() = super() and kmQuePuedeVolar > 10
}

class Duende inherits Criatura{
  override method poderOfensivo() = super() * 1.1
  override method esAstuta() = false

}


//roles
object guardian {
  method poderExtra() = 100
  method esExtraordinario(criatura) = criatura.poderMagico() > 50
  method nuevoRol() = new Domador(mascotas=[new MascotaMitologica(tieneCuernos=false, edad=1)])
}

class Domador {
  const property mascotas = []
  method poderExtra() = 150 * self.cantidadMascotasConCuernos()
  method domesticar(mascota) {
    mascotas.add(mascota)
  }
  method cantidadMascotasConCuernos() = mascotas.count({mascota => mascota.tieneCuernos()})
  method sonTodasMascotasVeteranas() = mascotas.all({mascota => mascota.esVeterana()})
  method esExtraordinario(criatura) = criatura.poderMagico() >= 15 and self.sonTodasMascotasVeteranas()
  method nuevoRol() {if (self.cantidadMascotasConCuernos() > 0) {return hechicero} else throw new Exception(message="No se puede cambiar a hechicero sin mascotas con cuernos")
}
  }

object hechicero {
  method poderExtra() = 0
  method esExtraordinario(criatura) = true
  method nuevoRol() = guardian

}

//Mascota

class MascotaMitologica{
  const property tieneCuernos
  const property edad  

  method esVeterana() = edad >= 10
}