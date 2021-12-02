unit monsterHunterGestionCombatJoueur;

{$mode objfpc}{$H+}
{$codepage utf8}

// ============================================================================= INTERFACE ======================================================================================
interface

uses
  Classes, SysUtils, monsterHunterJoueur, monsterHunterMonstre, monsterHunterCombatIHM, monsterHunterGestionCombatMonstre, monsterHunterArmesEtArmures, monsterHunterVille;

  // ------------------------------------------------- Types ---------------------------------------------


  // ------------------------------------------------- VARIABLES ---------------------------------------------


  // ------------------------------------------ FONCTIONS ET PROCEDURES --------------------------------------

   //Fonction qui gère la précision en fonction de l'arme
   function precisionArme(esquive:integer):integer;

   //procedure qui calcule le nombre de dégats que vas prendre le joueur en fonction de l'esquive, la tankiness, les dégats du monstre
   function calculDmgJoueur ():integer;

   //procedure qui inflige des dégats au joueur
   procedure degatsCombatJoueur(dmg : integer);

   //procedure qui vérifie la mort du monstre
   procedure estMortJoueur ();

   //Procedure qui fait fuir le joueur
   procedure fuiteJoueur ();

// =========================================================================== IMPLEMENTATION ===================================================================================

implementation

//Constantes
const
  maxDef = 1650;
  dmgBombe =  50;


//Fonction qui gère la précision en fonction de l'arme
function precisionArme(esquive:integer):integer;
begin
  case getJoueur.armePortee.arme of
  epee : precisionArme := round(esquive * 0.1);
  hache : precisionArme := round(esquive * 0.05);
  marteau : precisionArme := round(esquive * 0);
  couteau : precisionArme := round(esquive * 0.2);
  end;

end;

//Fonction qui renvoie un montant de réduction en fonction de la défense
function reductionDmgArmure ():Real;
var
  totalDefense : real;

begin

  //On cumule la défense  de chaque pièce d'armure
  totalDefense := getJoueur.armurePortee[0].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[1].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[2].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[3].valeurDefense;
  totalDefense := totalDefense + getJoueur.armurePortee[4].valeurDefense;

  //On renvoie un pourcentage de réduction
  reductionDmgArmure := totalDefense / maxDef;
end;

//Fonction qui renvoie le taux d'esquive d'un joueur en fonction de son armure
function tauxEsquive(): integer;
begin

    //On cumule les valeurs d'esquive à renvoyer
    tauxEsquive := round(getJoueur.armurePortee[0].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[1].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[2].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[3].tauxEsquive);
    tauxEsquive := tauxEsquive +  round(getJoueur.armurePortee[4].tauxEsquive);

end;

//procedure qui inflige des dégats au joueur
procedure degatsCombatJoueur(dmg : integer);
begin
  if dmg > getJoueur().vie then modifierVieJoueur(0)
  else modifierVieJoueur(getJoueur().vie - dmg);

end;

//procedure qui calcule le nombre de dégats que vas prendre le joueur en fonction de l'esquive, la tankiness, les dégats du monstre
function calculDmgJoueur ():integer;
var
  dmg : integer;

begin
  Randomize;

  //On regarde si le joueur esquive ici il n'esquive pas
  if random(101) > tauxEsquive() then
  begin
    //On mesure les dégats en fonction de la réduction de dégats
    dmg := round(aleaTypeAttaqueMonstre() * (1 - reductionDmgArmure()));

  end

  //Sinon il esquive
  else dmg := 0;

  calculDmgJoueur := dmg

end;

//Procedure qui fait fuir le joueur
procedure fuiteJoueur ();
begin
    retirerArgentJoueur(100);
end;

//procedure qui vérifie la mort du monstre
procedure estMortJoueur ();
var
  item:integer;
begin

    //Si il est mort
    if getJoueur().vie = 0 then
      begin

        //On fait perdre l'inventaire du joueur
        //for item := 0 to

        //On remet les pv du joueur au max
        modifierVieJoueur(100);

        //On affiche le game over


        //On retourne en ville
        ville();

      end;
end;

end.

