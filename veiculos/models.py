from django.db import models

# Create your models here.


class Category(models.Model):
    name = models.CharField(max_length=255)


class Vehicle(models.Model):
    category = models.ForeignKey(
        Category,
        on_delete=models.PROTECT,
        related_name="vehicles"
    )
    brand = models.CharField("Marca", max_length=255)
    model = models.CharField("Modelo", max_length=255)
