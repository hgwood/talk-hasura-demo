- ouvrir console Hasura
- présenter les 4 onglets
- aller dans data
- track les 2 tables
- aller dans grahiql
- passer dans graphql playground
- faire une requête sur les employés
- voir qu'on a pas de relation sur le manager
- retourner sur hasura
- dans data > employees > relationship
- ajouter la relation manager_id > employee.id et l'appeler manager
- ajouter les 2 autres relations proposées
(fichier metadata1.json)
- retourner dans le playground et démontrer une requête qui utilise toutes les relations
```
{
  employees {
    first_name
    last_name
    manager {
      first_name
      last_name
    }
    employees {
      first_name
      last_name
      moods(order_by: [{year: desc},{month:desc}] limit: 1) {
        value
      }
    }
  }
}
```
- montrer l'insertion d'un employé
mutation {
  insert_employees(
    objects: [
      {
        first_name: "A"
        last_name: "B"
        manager_id: 1
      }
    ]
  ) {
    returning {
      id
      manager_id
    }
  }
}
- montrer qu'on peut insérer le manager en même temps
mutation {
  insert_employees(
    objects: [
      {
        first_name: "A"
        last_name: "B"
        manager: {
          data: {
            first_name: "M"
            last_name: "C"
          }
        }
      }
    ]
  ) {
    returning {
      id
      manager_id
    }
  }
}
- montrer qu'on peut upsert
mutation {
  insert_employees(
    objects: [
      {
        first_name: "A"
        last_name: "B"
        manager: {
          data: {
            id: 1
            first_name: "M"
            last_name: "C"
          }
          on_conflict: {
            constraint: employees_pkey
            update_columns: [id]
          }
        }
      }
    ]
  ) {
    returning {
      id
      manager_id
    }
  }
}
- montrer une insertion qui entraine un conflit
{
  insert_moods(
    objects: [
      {
        employee_id: 1
        value: "cool"
        month: 9
        year: 2019
      }
    ]
  ) {
    id
  }
}
- montrer une insertion "non autorisé" (sur l'année précédente)
{
  insert_moods(
    objects: [
      {
        employee_id: 1
        value: "cool"
        month: 9
        year: 2018
      }
    ]
  ) {
    id
  }
}
- aller dans les permissions de la table moods dans hasura
- ajouter une restriction sur insert
  - no row check
  - column : seulement value
  - preset sur employee_id
(fichier metadata2.json)
- sur playground, ajouter les headers role et user id
- montrer qu'on ne peut plus insérer en choisissant month et year
- passer aux slides sur l'authentification
- ajouter un event triggers sur les humeurs
(ficher metadata4.json)
- ajouter une nouvelle humeur pour déclencher le trigger
- montrer les logs de l'event
- on passe aux remote schemas
- supprimer la relation de moods vers employees
- untrack employees dans data
- ajouter le remote schema http://employees:8080/v1/graphql
- faire une requête sur les employés pour montrer que ça fonctionne
{
  employees {
    id
  }
}
- montrer qu'on a plus de relation de moods vers employees
- ajouter la remote relationship
- montrer que ça fonctionne
{
  moods {
    value
    employee {
      first_name
      last_name
      employees {
        first_name
      }
    }
  }
}
