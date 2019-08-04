import tkinter as tk
import math


class Matrix3:
    def __init__(self, i, j, k):
        self.i = i
        self.j = j
        self.k = k

    def __mul__(self, other):
        """
        Multiplies two 3-dimensional matrices with each other
        """
        return Matrix3(
            self.i * other,
            self.j * other,
            self.k * other,
        )

    def __repr__(self):
        return f"[{self.i}, {self.j}, {self.k}]"

    def __str__(self):
        return self.__repr__()


class Vec3:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def project(self, distance):
        return Vec3(
            self.x / (distance - self.z),
            self.y / (distance - self.z),
            1,
        )

    def __add__(self, other):
        return Vec3(
            self.x + other.x,
            self.y + other.y,
            self.z + other.z,
        )

    def __mul__(self, other):
        if isinstance(other, Vec3):
            return Vec3(
                other.x * self.x,
                other.y * self.y,
                other.z * self.z,
            )
        elif isinstance(other, Matrix3):
            return (other.i * self.x +
                    other.j * self.y +
                    other.k * self.z)
        else:
            return Vec3(
                other * self.x,
                other * self.y,
                other * self.z,
            )

    def __repr__(self):
        return f"({self.x:.2F}, {self.y:.2F}, {self.z:.2F})"

    def __str__(self):
        return self.__repr__()


class Polygon:
    def __init__(self, points, _position=Vec3(0, 0, 0), _scale=1):
        self.points = points
        self._position = _position
        self._scale = _scale

    def position(self, _position):
        return Polygon(self.points, self._position + _position, self._scale)

    def offset(self, _offset):
        return Polygon(
            list(map(lambda p: p + _offset, self.points)),
            self._position,
            self._scale,
        )

    def transform(self, _transform):
        return Polygon(
            list(map(lambda p: p * _transform, self.points)),
            self._position,
            self._scale,
        )

    def scale(self, _scale):
        return Polygon(self.points, self._position, self._scale * _scale)

    def project(self, point):
        return point.project(10) * self._scale + self._position

    def draw(self, canvas):
        last = self.project(self.points[-1])
        for point in self.points:
            point = self.project(point)

            canvas.create_line(last.x, last.y, point.x, point.y, fill="red")
            last = point

    def __repr__(self):
        return str(self.points)

    def __str__(self):
        return self.__repr__()


class Mesh:
    def __init__(self, polys):
        self.polys = polys

    def position(self, _position):
        return Mesh(
            list(map(lambda p: p.position(_position), self.polys)),
        )

    def offset(self, _offset):
        return Mesh(
            list(map(lambda p: p.offset(_offset), self.polys)),
        )

    def transform(self, _transform):
        return Mesh(
            list(map(lambda p: p.transform(_transform), self.polys)),
        )

    def scale(self, _scale):
        return Mesh(
            list(map(lambda p: p.scale(_scale), self.polys)),
        )

    def rotateX(self, angle):
        return self.transform(Matrix3(
            Vec3(1, 0, 0),
            Vec3(0, math.cos(angle), -math.sin(angle)),
            Vec3(0, math.sin(angle), math.cos(angle)),
        ))

    def rotateY(self, angle):
        return self.transform(Matrix3(
            Vec3(math.cos(angle), 0, math.sin(angle)),
            Vec3(0, 1, 0),
            Vec3(-math.sin(angle), 0, math.cos(angle)),
        ))

    def rotateZ(self, angle):
        return self.transform(Matrix3(
            Vec3(math.cos(angle), -math.sin(angle), 0),
            Vec3(math.sin(angle), math.cos(angle), 0),
            Vec3(0, 0, 1),
        ))

    def rotateXYZ(self, angle):
        """
        Like rotateX(angle).rotateY(angle).rotateZ(angle) but uses
        matrix multiplication to only perform one transform. There's
        absolutely no reason for this function to exist other than
        testing that.
        """
        return self.transform(Matrix3(
            Vec3(1, 0, 0),
            Vec3(0, math.cos(angle), -math.sin(angle)),
            Vec3(0, math.sin(angle), math.cos(angle)),
        ) * Matrix3(
            Vec3(math.cos(angle), 0, math.sin(angle)),
            Vec3(0, 1, 0),
            Vec3(-math.sin(angle), 0, math.cos(angle)),
        ) * Matrix3(
            Vec3(math.cos(angle), -math.sin(angle), 0),
            Vec3(math.sin(angle), math.cos(angle), 0),
            Vec3(0, 0, 1),
        ))

    def draw(self, canvas):
        for poly in self.polys:
            poly.draw(canvas)

    def __repr__(self):
        return str(self.polys)

    def __str__(self):
        return self.__repr__()


root = tk.Tk()
canvas = tk.Canvas(bg="gray", width=500, height=500)
canvas.pack()

mesh = Mesh([
    Polygon([
        Vec3(-1, 1, 0),
        Vec3(1, 1, 0),
        Vec3(1, -1, 0),
        Vec3(-1, -1, 0),
    ]),
    Polygon([
        Vec3(-1, 1, 1),
        Vec3(1, 1, 1),
        Vec3(1, -1, 1),
        Vec3(-1, -1, 1),
    ]),
    Polygon([Vec3(-1, 1, 0), Vec3(-1, 1, 1)]),
    Polygon([Vec3(1, 1, 0), Vec3(1, 1, 1)]),
    Polygon([Vec3(1, -1, 0), Vec3(1, -1, 1)]),
    Polygon([Vec3(-1, -1, 0), Vec3(-1, -1, 1)]),
])

mesh = mesh.position(Vec3(250, 250, 0))
mesh = mesh.scale(1000)
mesh = mesh.offset(Vec3(-0.025, 0.025, 0))

angle = 0


def update():
    global angle, mesh

    canvas.delete("all")
    mesh.rotateXYZ(angle).draw(canvas)
    root.after(10, update)
    canvas.update()

    angle += 0.005


update()
root.mainloop()
