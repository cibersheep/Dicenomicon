//-- dice rolls --//
function roll(sides) {
    return Math.floor((Math.random() * sides) + 1);
}

//dice text name
function diceName(unit) {
	switch(unit) {
	  case 2:
		return "Coin"
		break;
	  case 4:
		return "Tetrahedron"
		break;
	  case 6:
		return "Cube"
		break;
	  case 8:
		return "Octahedron"
		break;
	  case 10:
		return "Deltahedron"
		break;
	  case 12:
		return "Dodecahedron"
		break;
	  case 20:
		return "Icosahedron"
		break;
	  default:
		return "Hectogon"
	}
}

//dice text name
function diceImage(unit) {
    switch(unit) {
	  case 2:
		return "d2"
		break;
	  case 4:
		//week yellow
		return "d4"
		break;
	  case 6:
		//today blue
		return "d6"
		break;
	  case 8:
	  	//today blue
		return "d8"
		break;
	  case 10:
		//today blue
		return "d10"
		break;
	  case 12:
	    //today blue
		return "d12"
		break;
	  case 20:
	    //month red
		return "d20"
		break;
	  default:
		return "d100"
	}
}
