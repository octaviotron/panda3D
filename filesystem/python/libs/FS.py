import subprocess
import json
import os
from typing import List, Dict, Any, Optional


class FSExplorador:
    """
    Explorador de sistema de archivos que usa `tree` para obtener información
    en formato JSON y ofrece filtros para directorios, archivos y enlaces.
    """

    def __init__(self) -> None:
        self.fsruta: str = ""
        self.salida: List[Dict[str, Any]] = []
        self._last_archivos:  List[Dict[str, Any]] = []
        self._last_directorios: List[Dict[str, Any]] = []
        self._last_vinculos:  List[Dict[str, Any]] = []

    # ---------- helpers ----------
    @staticmethod
    def _size_to_bytes(size_str: str) -> int:
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
        for unit in ("B", "K", "M", "G"):
            if b < 1024.0:
                return f"{b:.1f} {unit}".rstrip("0").rstrip(".")
            b /= 1024.0
        return f"{b:.1f} T".rstrip("0").rstrip(".")

    # ---------- lectura ----------
    def leefs(self, ruta: str) -> str:
        """
        Actualiza la ruta interna y recarga la salida.
        Devuelve cadena vacía si OK, o mensaje de error si falla.
        """
        if not os.path.exists(ruta):
            msg = f"Error: la ruta '{ruta}' no existe o no es accesible."
            self.salida = [{"error": msg}]
            self.fsruta = ruta
            return msg

        cmd = [
            "tree",
            "-L", "1",
            "-J", "-a", "-p", "-u", "-g", "-h", "-D",
            "--dirsfirst", ruta
        ]
        try:
            res = subprocess.run(cmd, capture_output=True, text=True, check=True)
            self.salida = json.loads(res.stdout)
            self.fsruta = ruta
            return ""
        except subprocess.CalledProcessError as e:
            msg = f"Error ejecutando 'tree': {e.stderr.strip()}"
            self.salida = [{"error": msg}]
            return msg
        except json.JSONDecodeError:
            msg = "La salida de 'tree' no es JSON válido."
            self.salida = [{"error": msg}]
            return msg

    # ---------- filtros ----------
    def _elementos_directos(
        self,
        tipo: str,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        if not self.salida or "contents" not in (self.salida[0] or {}):
            return []

        elementos = [
            item for item in self.salida[0]["contents"]
            if item.get("type") == tipo
        ]
        if not incluir_ocultos:
            elementos = [e for e in elementos if not e.get("name", "").startswith(".")]

        if ordenar_por is None:
            ordenar_por = "name"

        def _key(item: Dict[str, Any]):
            if ordenar_por == "size":
                return self._size_to_bytes(item.get("size", ""))
            return item.get(ordenar_por, "")

        return sorted(elementos, key=_key)

    def archivos(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        self._last_archivos = self._elementos_directos("file", incluir_ocultos, ordenar_por)
        return self._last_archivos

    def directorios(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        self._last_directorios = self._elementos_directos("directory", incluir_ocultos, ordenar_por)
        return self._last_directorios

    def vinculos(
        self,
        incluir_ocultos: bool = False,
        ordenar_por: Optional[str] = "name"
    ) -> List[Dict[str, Any]]:
        self._last_vinculos = self._elementos_directos("link", incluir_ocultos, ordenar_por)
        return self._last_vinculos

    # ---------- totales ----------

    def totales(self) -> Dict[str, Dict[str, Any]]:
        files   = self._last_archivos
        dirs    = self._last_directorios
        links   = self._last_vinculos

        total_bytes = sum(self._size_to_bytes(f.get("size", "")) for f in files)

        return {
            "directorios": {"cantidad": len(dirs),  "bytes": 0, "humano": "0 B"},
            "archivos":    {"cantidad": len(files), "bytes": total_bytes,
                            "humano": self._bytes_to_human(total_bytes)},
            "vinculos":    {"cantidad": len(links), "bytes": 0, "humano": "0 B"},
        }
