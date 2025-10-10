describe('AppComponent E2E', () => {

  beforeEach(() => {

    cy.intercept('GET', '/api/data', [
      { name: 'Paris', temperature: 22 },
      { name: 'Lyon', temperature: 18 }
    ]).as('getData');

    
    cy.intercept('GET', '/api/download', {
      statusCode: 200,
      body: 'fake-pdf-content',
      headers: {
        'content-type': 'application/pdf',
        'content-disposition': 'attachment; filename="fichier.pdf"'
      }
    }).as('downloadFile');

    // Visite de l'app
    cy.visit('http://localhost:4200');
  });

  it('affiche des données JSON quand on clique sur "Afficher JSON"', () => {
    cy.contains('📄 Afficher JSON').should('be.visible').click();
    cy.wait('@getData');

    cy.get('.square').should('have.length', 2);
    cy.get('.square').first().should('contain.text', '22°C');
    cy.get('.square').last().should('contain.text', '18°C');
  });

  it('télécharge un fichier quand on clique sur "Télécharger fichier"', () => {
    cy.contains('⬇️ Télécharger fichier').should('be.visible').click();
    cy.wait('@downloadFile');

    cy.get('@downloadFile.all').should('have.length', 1);
  });
});
