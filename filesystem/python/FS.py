import subprocess
import json
import os
from typing import List, Dict, Any, Tuple, Optional


class FSExplorador:
    """
    Explorador de sistema de archivos que usa `tree` para obtener información
    en formato JSON y ofrece filtros para directorios, archivos y enlaces.
    """

    def __init__(self, fsruta: str):
        self.fsruta: str = fsruta
        self.salida: List[Dict[str, Any]] = []

    # ----------------------------------------------------------
    # Utilidades internas
    # ----------------------------------------------------------
    @staticmethod
    def _size_to_bytes(size_str: str) -> int:
        """Convierte '4.0K', '1.5M', etc. a bytes."""
        if not size_str:
            return 0
        size_str = size_str.strip().upper()
        multi = {"K": 1024, "M": 1024 ** 2, "G": 1024 ** 3, "T": 1024 ** 4}
        for suf, mul in multi.items():
            if size_str.endswith(suf):
                try:
                    return int(float(size_str[:-1]) * mul)
                except ValueError:
                    return 0
        try:
            return int(float(size_str))
        except ValueError:
            return 0

    @staticmethod
    def _bytes_to_human(b: int) -> str:
        """Convierte bytes a cadena legible (B, K, M, G)."""
        for unit in ("B", "K", "M", "G"):
            if b < 1024.0:
                return f"{b:.1f} {unit}".rstrip("0").rstrip(".")
            b /= 1024.0
        return f"{b:.1f} T".rstrip("0").rstrip(".")

    # ----------------------------------------------------------
    # Lectura del sistema de archivos
    # ----------------------------------------------------------
    def leefs(self) -> str:
        """
        Ejecuta `tree` y actualiza la propiedad `salida` con el JSON completo.
        Si la ruta no existe retorna un string con el mensaje de error
        en vez de lanzar una excepción.
        """
        if not os.path.exists(self.fsruta):
            msg = (f"Error: la ruta '{self.fsruta}' no existe o no es accesible. "
                   f"Por favor verifique el nombre y los permisos.")
            self.salida = [{"error": msg}]
            return msg

        cmd = [
            "tree",
            "-L", "1",
            "-J", "-a", "-p", "-u", "-g", "-h", "-D",
            "--dirsfirst", self.fsruta
        ]
        try:
            res = subprocess.run(cmd, capture_output=True, text=True, check=True)
            self.salida = json.loads(res.stdout)
            return ""
        except subprocess.CalledProcessError as e:
            msg = f"Error al ejecutar 'tree': {e.stderr.strip()}"
            self.salida = [{"error": msg}]
            return msg
        except json.JSONDecodeError as e:
            msg = "La salida de 'tree' no es JSON válido."
            self.salida = [{"error": msg}]
            return msg

    # ----------------------------------------------------------
    # Métodos de obtención de elementos
    # ----------------------------------------------------------
    def _elementos_directos(
        self,
        tipo: str,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        if not self.salida or "contents" not in self.salida[0]:
            return []

        elementos = [
            item for item in self.salida[0]["contents"]
            if item.get("type") == tipo
        ]
        if not incluir_ocultos:
            elementos = [e for e in elementos if not e.get("name", "").startswith(".")]

        if ordenar_por is None:
            ordenar_por = "name"

        def _key_func(item: Dict[str, Any]):
            if ordenar_por == "size":
                return self._size_to_bytes(item.get("size", ""))
            return item.get(ordenar_por, "")

        return sorted(elementos, key=_key_func)

    def directorios(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        return self._elementos_directos("directory", incluir_ocultos, ordenar_por)

    def archivos(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        return self._elementos_directos("file", incluir_ocultos, ordenar_por)

    def vinculos(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        return self._elementos_directos("link", incluir_ocultos, ordenar_por)

    # ----------------------------------------------------------
    # Totales
    # ----------------------------------------------------------
    def totales(self, incluir_ocultos: bool = False) -> Dict[str, Dict[str, Any]]:
        """
        Retorna un diccionario con tres claves: 'directorios', 'archivos' y 'vinculos'.
        Cada una contiene:
            - 'cantidad' : int
            - 'bytes'    : int
            - 'humano'   : str
        """
        files = self.archivos(incluir_ocultos)
        total_bytes = sum(self._size_to_bytes(f.get("size", "")) for f in files)
        return {
            "directorios": {"cantidad": len(self.directorios(incluir_ocultos)),
                            "bytes": 0,
                            "humano": "0 B"},
            "archivos":    {"cantidad": len(files),
                            "bytes": total_bytes,
                            "humano": self._bytes_to_human(total_bytes)},
            "vinculos":    {"cantidad": len(self.vinculos(incluir_ocultos)),
                            "bytes": 0,
                            "humano": "0 B"}
        }


# ----------------------------------------------------------
# Ejemplo de uso
# ----------------------------------------------------------
if __name__ == "__main__":
    explorador = FSExplorador("/home/tr0n")
    error_msg = explorador.leefs()
    if error_msg:
        print(error_msg)
    else:
        #print("Directorios:", explorador.directorios())
        #print("Directorios:", explorador.directorios(incluir_ocultos=False, ordenar_por="size"))
        print("Archivos:", explorador.archivos())
        #print("Vínculos:", explorador.vinculos())
        print("Totales:", explorador.totales())
