#  Flujo de Pull Request 

## 1. Actualizar la rama `main`
```bash
git checkout main
git pull origin main
```

---

## 2. Crear una nueva rama
Usa nombres claros (ej: `feat/rooms-index`, `fix/booking-nil`).

```bash
git switch -c feat/feature_a_trabajar
# o git checkout -b feat/rooms-index
```

---

## 3. Hacer cambios y commits
```bash
git status

git add archivo1.rb archivo2.rb

git commit -m "feat(rooms): add index view with cards"
```

---

## 4. Subir la rama al remoto
```bash
git push -u origin feat/rooms-index
```

---

## 5. Crear el Pull Request
### Opción A: GitHub Web
1. Ve a tu repo en GitHub.  
2. Aparecerá el banner **"Compare & Pull Request"** → haz clic.  
3. Revisa que **base = `main`** y **compare = `feat/rooms-index`**.  
4. Completa título y descripción.  
   - Contexto  
   - Qué cambió  
   - Cómo probar  
   - Checklist  

### Opción B: GitHub CLI
```bash
gh pr create --base main --head feat/rooms-index --fill
```

---

## 6. Iterar hasta aprobación
- Si hay errores → corrige → `git add` → `git commit` → `git push`.  
- El PR se actualiza solo con cada push.  

---

## 7. Hacer merge a `main`
En GitHub, cuando el PR esté aprobado:
- **Recomendado**: **Squash and merge** → deja un commit limpio.  
- Alternativas: *Merge commit* o *Rebase and merge*.  

---

## 8. Borrar la rama (opcional pero recomendado)
En GitHub aparece botón **“Delete branch”** al hacer merge.  
También en local:

```bash
git checkout main
git pull origin main
git branch -d feat/rooms-index
```

---

#  Resumen 
```bash
git checkout main
git pull origin main
git checkout -b feat/nueva-funcionalidad
# ... editar archivos ...
git add .
git commit -m "feat: descripcion clara"
git push -u origin feat/nueva-funcionalidad
# Crear PR en GitHub → Merge → Borrar rama
```

---

# Ejemplo de un template de PR, aunque podemos trabajar sin uno en caso de que no quieran complicarse tanto.

##  Título

---

##  Contexto

---

##  Cambios realizados
- [ ] Descripción clara de cada cambio
- [ ] Otro cambio relevante
- [ ] Ajustes menores

---

##  Cómo probar
1. Pasos para probar los cambios
2. Datos de prueba (si aplica)
3. Screenshots o GIFs (si es UI)

---

##  Checklist
- [ ] Código probado localmente
- [ ] CI/CD pasa correctamente
- [ ] Tests actualizados/creados
- [ ] Documentación actualizada (si aplica)

---

##  Issues relacionados
