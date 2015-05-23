//-- dice rolls --//
function roll(sides){
    return Math.floor((Math.random() * sides ) + 1);
}


//dice text name
function diceName(unit){
    if(unit === 4){
    //week yellow
    return "Tetrahedron"
    } else if(unit === 6){
    //today blue
    return "Cube"
    } else if(unit === 8){
    //today blue
    return "Octahedron"
    }else if(unit === 10){
    //today blue
    return "Deltahedron"
    }else if(unit === 12){
    //today blue
    return "Dodecahedron"
    }else {
    //month red
    return "Icosahedron"
    }
}

//dice text name
function diceImage(unit){
    if(unit === 4){
    //week yellow
    return "d4"
    } else if(unit === 6){
    //today blue
    return "d6"
    } else if(unit === 8){
    //today blue
    return "d8"
    }else if(unit === 10){
    //today blue
    return "d10"
    }else if(unit === 12){
    //today blue
    return "d12"
    }else {
    //month red
    return "d20"
    }
}
