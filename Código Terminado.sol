// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
 
contract Datos{
/*La variable privada string nombre.
La variable privada string apellido.
La variable privada string curso.
La variable privada address docente.
La variable privada mapping(string => T) notas_materias.*/
    string private _nombre;
    string private _apellido;
    string private _curso;
    int[] private notas;
    string[] private materias;
    mapping(string => uint) private notas_materias; //materia => nota (key = materia, value = nota)
    address private _docente;
 
/*Un constructor que tome nombre, apellido y curso y los asigne dentro del
smart contract, a su vez debe asignar a la variable docente el address de quien
llamó a la función.
*/
 constructor(string memory nombre_, string memory apellido_, string memory curso_){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
 }
function apellido() public view returns (string memory){
        return _apellido;
}
 
//nombre_completo() devuelve el nombre y el apellido del estudiante como string.
 
function nombre_completo() public view returns (string memory){
        return string(bytes.concat(bytes(_nombre)," ",bytes(_apellido)));
}
/*contract StringConcatation{
    function AppendString(string memory _nombre, string memory _apellido) public pure returns (string memory) {
        return string(abi.  encodePacked(_nombre," ",_apellido));
    }
}*/

 
//curso() devuelve el curso del alumno como string.
function curso() public view returns (string memory){
        return _curso;
}
 
/*set_nota_materia(T nota, string memory materia) asigna el valor notas_materias a
nota donde la key es la materia. La nota se recibe como un entero del 1 al 100.
Atención, solo el docente registrado puede llamar a esta función.*/
 
function set_nota_materia(string memory materia, uint nota) public{
        require(msg.sender == _docente, "Solo el docente puede asignar notas");
        notas_materias[materia]= nota;
        materias.push(materia);
    }
 
/*nota_materia(string memory materia) devuelve la nota del Estudiante dada una
materia.*/
 
function nota_materia(string memory materia) public view returns (uint){
        return notas_materias[materia];
}
 
/*aprobo(string memory materia) devuelve True si solo si el alumno está aprobado en
la materia. La materia se aprueba con 6/10 o más.*/
 
function aprobo (string memory materia) public view returns (bool){
    bool _aprobado;
    if (notas_materias[materia] >= 60){
        _aprobado = true;
    }
    else{
        _aprobado = false;
    }
    return _aprobado;
}
 
//promedio() devuelve un entero con el promedio del alumno.
 
function promedio() public view returns (uint){
    uint promediofinal;
    for (uint i=0; i<materias.length; i++){
        promediofinal += notas_materias[materias[i]];
    }
    return promediofinal/materias.length;
 
}
}
