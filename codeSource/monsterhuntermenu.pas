unit monsterHunterMenu;

{$mode objfpc}{$H+}

// ============================================================================= INTERFACE ======================================================================================
interface
uses
  Classes, SysUtils,monsterHunterMenuIHM,monsterHunterJoueur, monsterHunterArmesEtArmures,monsterHunterMonstre,monsterHunterCantine;


// ------------------------------------------------- PROCEDURES ---------------------------------------------
// Initialisation du jeu au lancement
procedure initialisationJeu();
procedure menu();


// =========================================================================== IMPLEMENTATION ===================================================================================
implementation




// Affiche le message lorsque l'on quitte
procedure quitter();
begin
  //quitterIHM();
end;


// Affiche les crédits
procedure credits();
begin
  creditsIHM();
  readln();
  menu();
end;


// Affiche les différentes sauvegardes
procedure sauvegarde();
begin
  sauvegardeIHM();
  menu();
end;


// Menu principal
procedure menu();
var
  choix: string;
begin
  choix := menuIHM();
  if (choix = '1') then creationPersonnage()
  else if (choix = '2') then sauvegarde()
  else if (choix = '3') then credits()
  else if (choix = '4') then quitter()
  else menu();
end;



// Initialisation du jeu (remplissage des variables avec les données)
procedure initialisationJeu();
begin
  Randomize;
  remplirArmuresDisponibles('nomsStatsObjets/armures.csv');
  remplirArmesDisponibles('nomsStatsObjets/armes.csv');
  remplirCraftArmesDisponibles('fabrication/craftArmes.csv');
  remplirCraftArmuresDisponibles('fabrication/craftArmures.csv');
  remplirItemsDeCraftDisponibles('fabrication/itemsDeCraft.csv');
  remplirNourrituresDisponibles('nomsStatsObjets/nourritures.csv');
  initialisationMonstres('attributsMonstres/monstresAttributs.csv');

  initialisationPersonnage();
  affichageNomStudio();
  affichageLogo();
  menu();
end;



end.

