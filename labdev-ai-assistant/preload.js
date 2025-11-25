// Preload script para comunicación entre el botón de la barra de título y la extensión

(function() {
    'use strict';
    
    // Escuchar mensajes del botón en la barra de título
    window.addEventListener('message', (event) => {
        if (event.data && event.data.type === 'executeCommand') {
            const command = event.data.command;
            if (command === 'labdev-ai.openChat') {
                // Intentar ejecutar el comando de la extensión
                try {
                    if (window.vscode && window.vscode.commands) {
                        window.vscode.commands.executeCommand(command);
                    }
                } catch (e) {
                    console.log('AI Assistant button clicked:', command);
                }
            }
        }
    });
    
    // Registrar evento personalizado para VSCode
    document.addEventListener('vscode:runCommand', (event) => {
        const command = event.detail.command;
        if (command && window.vscode && window.vscode.commands) {
            window.vscode.commands.executeCommand(command);
        }
    });
    
    console.log('LabDev AI Assistant preload initialized');
})();
