let contador = 0;
const displayContador = document.getElementById('contador-total');

function formatoContador(valor) {
  return valor.toLocaleString().padStart(4, '0')
}

function actualizarContador () {
  displayContador.textContent = formatoContador(contador);
}

function sumarBoton() {
  contador = contador + 1;
  actualizarContador();
}

function reiniciarBoton() {
  contador = 0;
  actualizarContador();
}

function restarBoton() {
  if (contador > 0) {
    contador = contador - 1;
    actualizarContador();
  }
}

function mostrarHoraLocal() {
    const ahora = new Date();
    
    const opciones = {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
    };
    
    const fechaFormateada = ahora.toLocaleString('es-ES' , opciones);
    
    document.getElementById('horaActual').innerHTML = fechaFormateada;
}

mostrarHoraLocal(); 

setInterval(mostrarHoraLocal, 1000);