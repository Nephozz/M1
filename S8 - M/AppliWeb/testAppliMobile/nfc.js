document.getElementById('startScan').addEventListener('click', async () => {
    if ('NDEFReader' in window) {
        try {
            const reader = new NDEFReader();
            await reader.scan();
            console.log("Scan démarré.");

            reader.onreading = event => {
                const output = document.getElementById('output');
                output.innerHTML = ''; // Nettoie le contenu précédent
                event.message.records.forEach(record => {
                    const textDecoder = new TextDecoder();
                    output.innerHTML += `Type d'enregistrement : ${record.recordType}<br>`;
                    output.innerHTML += `Type MIME : ${record.mediaType}<br>`;
                    output.innerHTML += `Données : ${textDecoder.decode(record.data)}<br><br>`;
                });
            };
        } catch (error) {
            console.error("Erreur NFC :", error);
            alert("Erreur lors du démarrage du scan NFC. Vérifiez que la fonctionnalité est supportée et autorisée.");
        }
    } else {
        alert("Web NFC n'est pas supporté par ce navigateur.");
    }
    // Envoyer les données à la servlet
    // sendDataToServlet(records);

    
});


async function sendDataToServlet(data) {
    try {
        const response = await fetch('http://yourserver.com/your-servlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        if (response.ok) {
            const jsonResponse = await response.json();
            console.log('Réponse du serveur :', jsonResponse);
        } else {
            console.error('Erreur HTTP', response.status, await response.text());
        }
    } catch (error) {
        console.error('Erreur lors de l\'envoi des données à la servlet:', error);
    }
}