//-- dice rolls --//
function roll(sides) {
    return Math.floor((Math.random() * sides) + 1);
}

//dice text name
function diceName(unit) {
	switch(unit) {
	  case 2:
		return i18n.tr("Coin")
		break;
	  case 4:
		return i18n.tr("Tetrahedron")
		break;
	  case 6:
		return i18n.tr("Cube")
		break;
	  case 8:
		return i18n.tr("Octahedron")
		break;
	  case 10:
		return i18n.tr("Deltahedron")
		break;
	  case 12:
		return i18n.tr("Dodecahedron")
		break;
	  case 20:
		return i18n.tr("Icosahedron")
		break;
	  default:
		return i18n.tr("Hectogon")
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
