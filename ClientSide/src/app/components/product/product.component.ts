import { Component, OnInit, ViewChild } from '@angular/core';
import { ProductService, Product } from '../../services/product.service';
import { CommonModule } from '@angular/common';
import { FormsModule, NgForm } from '@angular/forms';
import { Observable, of, timer } from 'rxjs';
import { catchError, mergeMap, retry, take } from 'rxjs/operators';

@Component({
  selector: 'app-product',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './product.component.html',
  styleUrl: './product.component.css'
})
export class ProductComponent implements OnInit {
  products: Product[] = [];
  product: Product = { id: 0, name: '', price: 0 };
  editMode = false;
  formSubmitted = false;
  @ViewChild('productForm') productForm!: NgForm;

  constructor(private productService: ProductService) {}

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(): void {
    timer(0, 2000).pipe(
      take(15),
      mergeMap(() => this.productService.getProducts().pipe(
        catchError(error => {
          console.error('Error loading products:', error);
          return of(null);
        })
      )),
      retry({ count: 14, delay: 2000 })
    ).subscribe((data) => {
      if (data) {
        this.products = data;
        console.log('Products loaded successfully');
      } else {
        console.log('Failed to load products after 15 attempts');
      }
    });
  }

  createProduct(): void {
    this.formSubmitted = true;
    if (this.productForm.valid) {
      this.productService.createProduct(this.product).subscribe(() => {
        this.loadProducts();
        this.resetForm();
      });
    }
  }

  editProduct(product: Product): void {
    this.product = { ...product };
    this.editMode = true;
    this.formSubmitted = false;
  }

  updateProduct(): void {
    this.formSubmitted = true;
    if (this.productForm.valid) {
      this.productService.updateProduct(this.product.id, this.product).subscribe(() => {
        this.loadProducts();
        this.resetForm();
      });
    }
  }

  deleteProduct(id: number): void {
    this.productService.deleteProduct(id).subscribe(() => {
      this.loadProducts();
    });
  }

  resetForm(): void {
    this.product = { id: 0, name: '', price: 0 };
    this.editMode = false;
    this.formSubmitted = false;
    if (this.productForm) {
      this.productForm.resetForm();
    }
  }
}