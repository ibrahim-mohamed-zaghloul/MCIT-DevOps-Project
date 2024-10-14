import { ComponentFixture, TestBed, fakeAsync, tick, discardPeriodicTasks } from '@angular/core/testing';
import { ProductComponent } from './product.component';
import { ProductService, Product } from '../../services/product.service';
import { of } from 'rxjs';
import { FormsModule } from '@angular/forms';

describe('ProductComponent', () => {
  let component: ProductComponent;
  let fixture: ComponentFixture<ProductComponent>;
  let productServiceSpy: jasmine.SpyObj<ProductService>;

  beforeEach(async () => {
    const spy = jasmine.createSpyObj('ProductService', ['getProducts', 'createProduct', 'updateProduct', 'deleteProduct']);

    await TestBed.configureTestingModule({
      imports: [ProductComponent, FormsModule],
      providers: [
        { provide: ProductService, useValue: spy }
      ]
    }).compileComponents();

    productServiceSpy = TestBed.inject(ProductService) as jasmine.SpyObj<ProductService>;
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ProductComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load products on init', fakeAsync(() => {
    const testProducts = [{ id: 1, name: 'Test Product', price: 100 }];
    productServiceSpy.getProducts.and.returnValue(of(testProducts));

    fixture.detectChanges(); // This will call ngOnInit
    tick(2000); // Wait for the first timer interval

    expect(productServiceSpy.getProducts).toHaveBeenCalled();
    expect(component.products).toEqual(testProducts);

    discardPeriodicTasks(); // Discard any remaining periodic timers
  }));

  it('should create a product', fakeAsync(() => {
    const newProduct: Product = { id: 0, name: 'New Product', price: 200 };
    component.product = newProduct;
    productServiceSpy.createProduct.and.returnValue(of(newProduct));
    productServiceSpy.getProducts.and.returnValue(of([newProduct]));

    // Mock the productForm
    component.productForm = {
      valid: true,
      resetForm: jasmine.createSpy('resetForm')
    } as any;

    component.createProduct();
    tick(); // Wait for the observable to complete

    expect(productServiceSpy.createProduct).toHaveBeenCalledWith(newProduct);
    expect(productServiceSpy.getProducts).toHaveBeenCalled();
    expect(component.product).toEqual({ id: 0, name: '', price: 0 });
    expect(component.productForm.resetForm).toHaveBeenCalled();

    discardPeriodicTasks(); // Discard any remaining periodic timers
  }));

  it('should set up edit mode', () => {
    const productToEdit: Product = { id: 1, name: 'Edit Product', price: 300 };

    component.editProduct(productToEdit);

    expect(component.product).toEqual(productToEdit);
    expect(component.editMode).toBeTrue();
  });

  it('should update a product', fakeAsync(() => {
    const updatedProduct: Product = { id: 1, name: 'Updated Product', price: 400 };
    component.product = updatedProduct;
    productServiceSpy.updateProduct.and.returnValue(of(updatedProduct));
    productServiceSpy.getProducts.and.returnValue(of([updatedProduct]));

    // Mock the productForm
    component.productForm = {
      valid: true,
      resetForm: jasmine.createSpy('resetForm')
    } as any;

    component.updateProduct();
    tick(); // Wait for the observable to complete

    expect(productServiceSpy.updateProduct).toHaveBeenCalledWith(1, updatedProduct);
    expect(productServiceSpy.getProducts).toHaveBeenCalled();
    expect(component.product).toEqual({ id: 0, name: '', price: 0 });
    expect(component.editMode).toBeFalse();
    expect(component.productForm.resetForm).toHaveBeenCalled();

    discardPeriodicTasks(); // Discard any remaining periodic timers
  }));

  it('should delete a product', fakeAsync(() => {
    const productId = 1;
    productServiceSpy.deleteProduct.and.returnValue(of(void 0));
    productServiceSpy.getProducts.and.returnValue(of([]));

    component.deleteProduct(productId);
    tick(); // Wait for the observable to complete

    expect(productServiceSpy.deleteProduct).toHaveBeenCalledWith(productId);
    expect(productServiceSpy.getProducts).toHaveBeenCalled();

    discardPeriodicTasks(); // Discard any remaining periodic timers
  }));
});