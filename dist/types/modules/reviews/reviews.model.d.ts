export declare const reviewsModel: {
    create: (userId: number, productId: number, rating: number, text: string, imageUrl?: string) => Promise<any>;
    findByProductId: (productId: number) => Promise<any[]>;
    findAllReviews: () => Promise<any[]>;
    update: (reviewId: number, userId: number, rating: number, text: string, imageUrl?: string, isAdmin?: boolean) => Promise<any>;
    remove: (reviewId: number, userId: number, isAdmin?: boolean) => Promise<boolean>;
};
