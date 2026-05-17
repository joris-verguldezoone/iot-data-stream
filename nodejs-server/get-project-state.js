import fs from "fs";
import path from "path";

/**
 * Ce script parcourt le dossier src/ et les fichiers de configuration
 * pour générer un résumé complet du code actuel à envoyer à l'IA.
 */

const EXCLUDED_DIRS = ["node_modules", ".git", "dist", "build", "generated"];
const INCLUDED_EXTENSIONS = [".ts", ".sh",".json"];

function getFiles(dir, fileList = []) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      if (!EXCLUDED_DIRS.includes(file)) {
        getFiles(filePath, fileList);
      }
    } else {
      if (INCLUDED_EXTENSIONS.includes(path.extname(file))) {
        fileList.push(filePath);
      }
    }
  });
  return fileList;
}

function generateSnapshot() {
  console.log("--- ANALYSE DE L'ÉTAT DU PROJET ---\n");
  
  const files = getFiles(process.cwd());
  let output = "Voici l'état actuel de mon projet Dota 2 Strategy Sandbox.\n\n";

  files.forEach(file => {
    const relativePath = path.relative(process.cwd(), file);
    const content = fs.readFileSync(file, "utf8");
    
    output += `### FICHIER : ${relativePath} ###\n`;
    output += "```" + (path.extname(file).slice(1) || "text") + "\n";
    output += content + "\n";
    output += "```\n\n";
  });

  // Enregistrer le résultat dans un fichier pour que l'utilisateur puisse le copier
  fs.writeFileSync("./docs/project_snapshot.txt", output);
  console.log("✅ Diagnostic terminé !");
  console.log("Le fichier 'project_snapshot.txt' a été généré.");
  console.log("Copiez son contenu et collez-le à Gemini avec le prompt suivant :");
  console.log("\nPrompt conseillé : 'Voici le code actuel de mon projet. Analyse l'architecture, vérifie les dépendances et dis-moi ce qu'il reste à faire pour terminer le Header et le Canvas.'");
}

generateSnapshot();